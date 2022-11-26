import { UpdateItemCommand } from '@aws-sdk/client-dynamodb'

import { dynamoClient } from '../libs/dynamo-client.js'

async function run() {
  try {
    const data = await dynamoClient.send(
      new UpdateItemCommand({
        TableName: 'orders',
        Key: {
          userName: { S: 'daniel' },
          orderDate: { S: '2022-12-01' }
        },
        UpdateExpression: 'SET totalValue = :newValue',
        ExpressionAttributeValues: {
          ':newValue': { N: '150' }
        },
        ReturnValues: 'ALL_NEW'
      })
    )

    console.log(JSON.stringify(data, null, 2))
  } catch (error) {
    console.error(error)
  }
}

run()
