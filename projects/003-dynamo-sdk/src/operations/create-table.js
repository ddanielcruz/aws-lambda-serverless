import { CreateTableCommand } from '@aws-sdk/client-dynamodb'

import { dynamoClient } from '../libs/dynamo-client.js'

async function run() {
  try {
    const data = await dynamoClient.send(
      new CreateTableCommand({
        AttributeDefinitions: [
          {
            AttributeName: 'userName',
            AttributeType: 'S'
          },
          {
            AttributeName: 'orderDate',
            AttributeType: 'S'
          }
        ],
        KeySchema: [
          {
            AttributeName: 'userName',
            KeyType: 'HASH'
          },
          {
            AttributeName: 'orderDate',
            KeyType: 'RANGE'
          }
        ],
        ProvisionedThroughput: {
          ReadCapacityUnits: 1,
          WriteCapacityUnits: 1
        },
        TableName: 'orders',
        StreamSpecification: {
          StreamEnabled: false
        }
      })
    )

    console.log(JSON.stringify(data, null, 2))
  } catch (error) {
    console.error(error)
  }
}

run()
