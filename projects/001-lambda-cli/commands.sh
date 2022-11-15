FUNCTION_NAME='hello-world'
ROLE_NAME='lambda-example'

# List existing functions
aws lambda list-functions

# Get function by name
aws lambda get-function --function-name $FUNCTION_NAME

# Invoking a function
aws lambda invoke \
  --function-name $FUNCTION_NAME \
  --cli-binary-format raw-in-base64-out \
  --payload file://event.json \
  invocation.json

# Invoke function and decode invocation logs
aws lambda invoke \
  --function-name $FUNCTION_NAME invocation.json \
  --cli-binary-format raw-in-base64-out \
  --payload file://event.json \
  --log-type Tail \
  --query 'LogResult' \
  --output text | base64 -d > logs.txt

# Create policy role and attach Lambda execution permission
aws iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

aws iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://trust-policy.json

aws iam attach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

# Get role ARN and set to a variable
ROLE_ARN=$(aws iam get-role --role-name $ROLE_NAME | jq -r .Role.Arn)

# Zip handler and deploy function
zip function.zip handler.js
aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --runtime nodejs16.x \
  --zip-file fileb://function.zip \
  --role $ROLE_ARN \
  --handler index.handler

# Get existing log groups and streams from a specific group
aws logs describe-log-groups --query "logGroups[*].logGroupName"
aws logs describe-log-streams \
  --log-group-name "/aws/lambda/$FUNCTION_NAME" \
  --query "logStreams[*].logStreamName"

# Get last log from a function/group and get its log events
LAST_LOG=$(aws logs describe-log-streams --log-group-name "/aws/lambda/$FUNCTION_NAME" --query "logStreams[*].logStreamName" | jq -r '.[-1]')
aws logs get-log-events \
  --log-group-name "/aws/lambda/$FUNCTION_NAME" \
  --log-stream-name "$LAST_LOG"

# Update function code
aws lambda update-function-code \
  --function-name $FUNCTION_NAME \
  --zip-file fileb://function.zip

# Update function configuration
aws lambda update-function-configuration \
  --function-name $FUNCTION_NAME \
  --environment "Variables={BUCKET=any-bucket}"

# Delete created function
aws lambda delete-function --function-name $FUNCTION_NAME
