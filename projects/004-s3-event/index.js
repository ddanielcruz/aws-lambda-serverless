import { PutItemCommand } from '@aws-sdk/client-dynamodb'
import { marshall } from '@aws-sdk/util-dynamodb'

import { dynamoClient, TABLE } from './dynamo-client.js'

const stringify = object => JSON.stringify(object, null, 2)

export const handler = async event => {
  console.debug('event', stringify(event))

  try {
    // Iterate received S3 records writing them to Dynamo table
    for (const record of event.Records) {
      const { object } = record.s3
      console.debug('object', object)

      // Create item to write
      const params = {
        TableName: TABLE,
        Item: marshall(object || {}, {
          removeUndefinedValues: true,
          convertClassInstanceToMap: true
        })
      }

      // Send request to put item in the table
      const result = await dynamoClient.send(new PutItemCommand(params))
      console.debug('result', stringify(result))
    }
  } catch (error) {
    console.error(error)
  }
}
