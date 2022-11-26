import { DynamoDBClient } from '@aws-sdk/client-dynamodb'

const region = process.env.DYNAMO_REGION || 'us-east-1'
export const dynamoClient = new DynamoDBClient({ region })
