TABLE="Orders"

# Create a new DynamoDB table
aws dynamodb create-table \
  --table-name $TABLE \
  --attribute-definitions \
      AttributeName=id,AttributeType=S \
      AttributeName=status,AttributeType=S \
  --key-schema \
      AttributeName=id,KeyType=HASH \
      AttributeName=status,KeyType=RANGE \
  --provisioned-throughput \
      ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --table-class STANDARD

# Describe created table to check if it was successfully created
aws dynamodb describe-table --table-name $TABLE

# Writing data into created table
aws dynamodb put-item \
  --table-name $TABLE \
  --item \
    '{"id": {"S": "1"}, "status": {"S": "IN_PROGRESS"}, "orderDate": {"S": "2022-11-24"}}'

aws dynamodb put-item \
  --table-name $TABLE \
  --item \
    '{"id": {"S": "1"}, "status": {"S": "COMPLETED"}, "orderDate": {"S": "2022-11-25"}, "totalPrice": {"N": "1250"}}'

# Reading table items. Consistent read enforces strongly consistency (CAP thereom)
aws dynamodb get-item --consistent-read \
  --table-name $TABLE \
  --key '{"id": {"S": "1"}, "status": {"S": "COMPLETED"}}'

# Update table item
aws dynamodb update-item \
  --table-name $TABLE \
  --key '{"id": {"S": "1"}, "status": {"S": "COMPLETED"}}' \
  --update-expression "SET totalPrice = :newValue" \
  --expression-attribute-values '{":newValue": {"N": "2000"}}' \
  --return-values ALL_NEW

# Querying data
aws dynamodb query \
  --table-name $TABLE \
  --key-condition-expression "id = :id" \
  --expression-attribute-values '{":id": {"S": "1"}}'
