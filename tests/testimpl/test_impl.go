package testimpl

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"os"
	"sort"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	r53 "github.com/aws/aws-sdk-go-v2/service/route53"
	r53types "github.com/aws/aws-sdk-go-v2/service/route53/types"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

const (
	expectedType            = "HTTPS"
	expectedFQDN            = "aws.amazon.com"
	expectedPort      int32 = 443
	expectedInterval  int32 = 30
	expectedThreshold int32 = 3
	expectedPath            = "/"
)

var (
	expectedRegions = []string{"eu-west-1", "us-east-1", "us-west-2"}
	expectedTags    = map[string]string{"Example": "complete"}
)

func normalizeDNSName(s string) string {
	s = strings.TrimSpace(strings.ToLower(s))
	if s == "" {
		return s
	}
	if !strings.HasSuffix(s, ".") {
		s += "."
	}
	return s
}

func awsRegion() string {
	for _, v := range []string{os.Getenv("AWS_REGION"), os.Getenv("AWS_DEFAULT_REGION")} {
		if v != "" {
			return v
		}
	}
	return "us-east-1"
}

func route53Client(t *testing.T) *r53.Client {
	t.Helper()
	cfg, err := config.LoadDefaultConfig(context.Background(), config.WithRegion(awsRegion()))
	require.NoError(t, err)
	return r53.NewFromConfig(cfg)
}

func randomHex(t *testing.T, bytes int) string {
	t.Helper()
	value := make([]byte, bytes)
	_, err := rand.Read(value)
	require.NoError(t, err)
	return hex.EncodeToString(value)
}

func getHealthCheck(t *testing.T, client *r53.Client, healthCheckID string) *r53types.HealthCheck {
	t.Helper()
	out, err := client.GetHealthCheck(context.Background(), &r53.GetHealthCheckInput{
		HealthCheckId: aws.String(healthCheckID),
	})
	require.NoError(t, err)
	require.NotNil(t, out.HealthCheck)
	require.NotNil(t, out.HealthCheck.HealthCheckConfig)
	return out.HealthCheck
}

func getHealthCheckTags(t *testing.T, client *r53.Client, healthCheckID string) map[string]string {
	t.Helper()
	out, err := client.ListTagsForResource(context.Background(), &r53.ListTagsForResourceInput{
		ResourceId:   aws.String(healthCheckID),
		ResourceType: r53types.TagResourceTypeHealthcheck,
	})
	require.NoError(t, err)
	require.NotNil(t, out.ResourceTagSet)

	tags := map[string]string{}
	for _, tag := range out.ResourceTagSet.Tags {
		tags[aws.ToString(tag.Key)] = aws.ToString(tag.Value)
	}
	return tags
}

func verifyHealthCheckConfiguration(t *testing.T, testCtx types.TestContext, client *r53.Client) {
	t.Helper()

	opts := testCtx.TerratestTerraformOptions()
	healthCheckID := terraform.Output(t, opts, "id")

	healthCheck := getHealthCheck(t, client, healthCheckID)
	cfg := healthCheck.HealthCheckConfig

	assert.Equal(t, expectedType, string(cfg.Type), "health check type should match expected test fixture value")
	assert.Equal(t, normalizeDNSName(expectedFQDN), normalizeDNSName(aws.ToString(cfg.FullyQualifiedDomainName)), "FQDN should match expected test fixture value")
	assert.Equal(t, expectedPort, aws.ToInt32(cfg.Port), "port should match expected test fixture value")
	assert.Equal(t, expectedInterval, aws.ToInt32(cfg.RequestInterval), "request interval should match expected test fixture value")
	assert.Equal(t, expectedThreshold, aws.ToInt32(cfg.FailureThreshold), "failure threshold should match expected test fixture value")
	assert.Equal(t, expectedPath, aws.ToString(cfg.ResourcePath), "resource path should match expected test fixture value")
	assert.Nil(t, cfg.SearchString, "search_string should be unset for HTTPS checks")
	assert.True(t, aws.ToBool(cfg.MeasureLatency), "measure_latency should match expected test fixture value")
	assert.False(t, aws.ToBool(cfg.Inverted), "invert_healthcheck should match expected test fixture value")
	assert.False(t, aws.ToBool(cfg.Disabled), "disabled should match expected test fixture value")
	assert.True(t, aws.ToBool(cfg.EnableSNI), "enable_sni should match expected test fixture value")

	gotRegions := make([]string, 0, len(cfg.Regions))
	for _, region := range cfg.Regions {
		gotRegions = append(gotRegions, string(region))
	}
	sort.Strings(gotRegions)
	sortedExpectedRegions := append([]string{}, expectedRegions...)
	sort.Strings(sortedExpectedRegions)
	assert.Equal(t, sortedExpectedRegions, gotRegions, "regions should match expected test fixture value")

	apiTags := getHealthCheckTags(t, client, healthCheckID)
	for key, expectedValue := range expectedTags {
		actualValue, ok := apiTags[key]
		require.True(t, ok, "tag %s should be present", key)
		assert.Equal(t, expectedValue, actualValue, "tag %s should match expected test fixture value", key)
	}
}

// verifyManagedHealthCheckWrite mutates and reverts a tag on the deployed module-managed health check.
func verifyManagedHealthCheckWrite(t *testing.T, testCtx types.TestContext, client *r53.Client) {
	t.Helper()

	opts := testCtx.TerratestTerraformOptions()
	healthCheckID := terraform.Output(t, opts, "id")
	writeTagKey := "terratest_write_probe"
	writeTagValue := "ok-" + randomHex(t, 4)

	_, err := client.ChangeTagsForResource(context.Background(), &r53.ChangeTagsForResourceInput{
		ResourceId:   aws.String(healthCheckID),
		ResourceType: r53types.TagResourceTypeHealthcheck,
		AddTags: []r53types.Tag{
			{
				Key:   aws.String(writeTagKey),
				Value: aws.String(writeTagValue),
			},
		},
	})
	require.NoError(t, err)

	t.Cleanup(func() {
		_, cleanupErr := client.ChangeTagsForResource(context.Background(), &r53.ChangeTagsForResourceInput{
			ResourceId:    aws.String(healthCheckID),
			ResourceType:  r53types.TagResourceTypeHealthcheck,
			RemoveTagKeys: []string{writeTagKey},
		})
		assert.NoError(t, cleanupErr)
	})

	apiTags := getHealthCheckTags(t, client, healthCheckID)
	assert.Equal(t, writeTagValue, apiTags[writeTagKey], "write test should update tags on the deployed health check")
}

// TestComposableComplete verifies deployed health-check configuration and performs write operations via the Route 53 API.
func TestComposableComplete(t *testing.T, testCtx types.TestContext) {
	client := route53Client(t)
	verifyHealthCheckConfiguration(t, testCtx, client)
	t.Run("route53ApiWriteOnManagedResource", func(t *testing.T) {
		verifyManagedHealthCheckWrite(t, testCtx, client)
	})
}

// TestComposableCompleteReadOnly verifies deployed health-check configuration using read-only Route 53 API calls.
func TestComposableCompleteReadOnly(t *testing.T, testCtx types.TestContext) {
	client := route53Client(t)
	verifyHealthCheckConfiguration(t, testCtx, client)
}
