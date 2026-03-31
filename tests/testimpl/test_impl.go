package testimpl

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"os"
	"sort"
	"strconv"
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

func terraformBoolOutput(t *testing.T, opts *terraform.Options, name string) bool {
	t.Helper()
	value, err := strconv.ParseBool(terraform.Output(t, opts, name))
	require.NoError(t, err)
	return value
}

func terraformInt32Output(t *testing.T, opts *terraform.Options, name string) int32 {
	t.Helper()
	value, err := strconv.ParseInt(terraform.Output(t, opts, name), 10, 32)
	require.NoError(t, err)
	return int32(value)
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
	expectedType := terraform.Output(t, opts, "type")
	expectedFQDN := terraform.Output(t, opts, "fqdn")
	expectedResourcePath := terraform.Output(t, opts, "resource_path")
	expectedRegions := terraform.OutputList(t, opts, "regions")
	expectedTags := terraform.OutputMap(t, opts, "expected_tags")

	healthCheck := getHealthCheck(t, client, healthCheckID)
	cfg := healthCheck.HealthCheckConfig

	assert.Equal(t, expectedType, string(cfg.Type), "health check type should match terraform output")
	assert.Equal(t, normalizeDNSName(expectedFQDN), normalizeDNSName(aws.ToString(cfg.FullyQualifiedDomainName)), "FQDN should match terraform output")
	assert.Equal(t, terraformInt32Output(t, opts, "port"), aws.ToInt32(cfg.Port), "port should match terraform output")
	assert.Equal(t, terraformInt32Output(t, opts, "request_interval"), aws.ToInt32(cfg.RequestInterval), "request interval should match terraform output")
	assert.Equal(t, terraformInt32Output(t, opts, "failure_threshold"), aws.ToInt32(cfg.FailureThreshold), "failure threshold should match terraform output")
	assert.Equal(t, expectedResourcePath, aws.ToString(cfg.ResourcePath), "resource path should match terraform output")
	assert.Equal(t, terraformBoolOutput(t, opts, "measure_latency"), aws.ToBool(cfg.MeasureLatency), "measure_latency should match terraform output")
	assert.Equal(t, terraformBoolOutput(t, opts, "invert_healthcheck"), aws.ToBool(cfg.Inverted), "invert_healthcheck should match terraform output")
	assert.Equal(t, terraformBoolOutput(t, opts, "disabled"), aws.ToBool(cfg.Disabled), "disabled should match terraform output")
	assert.Equal(t, terraformBoolOutput(t, opts, "enable_sni"), aws.ToBool(cfg.EnableSNI), "enable_sni should match terraform output")

	gotRegions := make([]string, 0, len(cfg.Regions))
	for _, region := range cfg.Regions {
		gotRegions = append(gotRegions, string(region))
	}
	sort.Strings(gotRegions)
	sort.Strings(expectedRegions)
	assert.Equal(t, expectedRegions, gotRegions, "regions should match terraform output")

	apiTags := getHealthCheckTags(t, client, healthCheckID)
	for key, expectedValue := range expectedTags {
		actualValue, ok := apiTags[key]
		require.True(t, ok, "tag %s should be present", key)
		assert.Equal(t, expectedValue, actualValue, "tag %s should match terraform output", key)
	}
}

func createAndDeleteHealthCheck(t *testing.T, client *r53.Client) {
	t.Helper()

	var randomSuffix [4]byte
	_, err := rand.Read(randomSuffix[:])
	require.NoError(t, err)

	callerReference := "terratest-write-" + hex.EncodeToString(randomSuffix[:])

	createOut, err := client.CreateHealthCheck(context.Background(), &r53.CreateHealthCheckInput{
		CallerReference: aws.String(callerReference),
		HealthCheckConfig: &r53types.HealthCheckConfig{
			Type:             r53types.HealthCheckTypeTcp,
			IPAddress:        aws.String("1.1.1.1"),
			Port:             aws.Int32(443),
			RequestInterval:  aws.Int32(30),
			FailureThreshold: aws.Int32(3),
		},
	})
	require.NoError(t, err)
	require.NotNil(t, createOut.HealthCheck)
	require.NotNil(t, createOut.HealthCheck.Id)

	createdHealthCheckID := aws.ToString(createOut.HealthCheck.Id)
	t.Cleanup(func() {
		_, deleteErr := client.DeleteHealthCheck(context.Background(), &r53.DeleteHealthCheckInput{
			HealthCheckId: aws.String(createdHealthCheckID),
		})
		assert.NoError(t, deleteErr)
	})

	created := getHealthCheck(t, client, createdHealthCheckID)
	require.NotNil(t, created.HealthCheckConfig)
	assert.Equal(t, string(r53types.HealthCheckTypeTcp), string(created.HealthCheckConfig.Type), "write-test health check should use TCP type")
	assert.Equal(t, "1.1.1.1", aws.ToString(created.HealthCheckConfig.IPAddress), "write-test health check should target the expected IP")
}

// TestComposableComplete verifies deployed health-check configuration and performs write operations via the Route 53 API.
func TestComposableComplete(t *testing.T, testCtx types.TestContext) {
	client := route53Client(t)
	verifyHealthCheckConfiguration(t, testCtx, client)
	t.Run("route53ApiWrite", func(t *testing.T) {
		createAndDeleteHealthCheck(t, client)
	})
}

// TestComposableCompleteReadOnly verifies deployed health-check configuration using read-only Route 53 API calls.
func TestComposableCompleteReadOnly(t *testing.T, testCtx types.TestContext) {
	client := route53Client(t)
	verifyHealthCheckConfiguration(t, testCtx, client)
}
