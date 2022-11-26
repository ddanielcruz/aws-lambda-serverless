import { DeleteTableCommand } from '@aws-sdk/client-dynamodb'

import { dynamoClient } from '../libs/dynamo-client.js'

async function run() {
  try {
    const data = await dynamoClient.send(
      new DeleteTableCommand({
        TableName: 'orders'
      })
    )

    console.log(JSON.stringify(data, null, 2))
  } catch (error) {
    console.error(error)
  }
}

run()
