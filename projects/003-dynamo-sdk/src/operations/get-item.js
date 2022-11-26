import { GetItemCommand, UpdateItemCommand } from '@aws-sdk/client-dynamodb'

import { dynamoClient } from '../libs/dynamo-client.js'

async function run() {
  try {
    const data = await dynamoClient.send(
      new GetItemCommand({
        TableName: 'orders',
        Key: {
          userName: { S: 'daniel' },
          orderDate: { S: '2022-12-01' }
        }
      })
    )

    console.log(JSON.stringify(data, null, 2))
  } catch (error) {
    console.error(error)
  }
}

run()
