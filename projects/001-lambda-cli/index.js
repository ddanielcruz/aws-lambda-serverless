exports.handler = async (event, context) => {
  console.log(JSON.stringify({ event, context }))
  return {
    statusCode: 200,
    body: JSON.stringify({ timestamp: new Date().toISOString() }, null, 2)
  }
}
