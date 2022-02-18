#!/bin/bash
set -e

mkdir ${BASE_PATH}/cicd/test/reports && touch ${BASE_PATH}/cicd/test/reports/test_output.log
cd ${BASE_PATH}/cicd/test
go mod init test

# Run terratest
echo "Running Terratest"
go get "github.com/gruntwork-io/terratest/modules/terraform"
go get "github.com/stretchr/testify/assert"
go get "strings"
go get "testing"
go get "fmt"
go get "github.com/gruntwork-io/terratest/modules/random"
go get "github.com/gruntwork-io/terratest/modules/aws"


go test test -timeout 10m -v | tee reports/test_output.log
retcode=${PIPESTATUS[0]}

echo "Creating Logs"
terratest_log_parser -testlog reports/test_output.log -outputdir reports

exit ${retcode}