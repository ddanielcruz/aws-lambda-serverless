import { DynamoDBClient } from '@aws-sdk/client-dynamodb'

const REGION = process.env.DYNAMO_REGION || 'us-east-1'
const TABLE = process.env.DYNAMO_TABLE || 's3-bucket-objects'
const dynamoClient = new DynamoDBClient({ region: REGION })

export { dynamoClient, TABLE }
