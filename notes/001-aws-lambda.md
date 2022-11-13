# AWS Lambda

AWS Lambda is the most popular serverless computing platform being used by millions of customers. It's a **compute service** that runs code without dealing with any servers or underlying services, responsible only for running the code.

It was designed for **event-driven architectures**, to perform actions on events triggered by any of AWS services, such as image upload to S3, HTTP requests on API gateway or database streams on DynamoDB. Any action on AWS platform can trigger a lambda.

The service is **scalable**, being able to process millions of requests and scale as needed, as long as we have enough quota on AWS. As other AWS services, we only **pay for the usage**, being the compute time in the lambda, much cheaper if we don't need a provisioned server all the time.

## How does AWS Lambda work?

Each lambda function runs in its own container on AWS infrastructure, such as a standalone Docker container. When a function is created, Lambda **packages** it into a new container and then executes that container on a **multi-region cloud clusters** of servers managed by AWS.

For each function container is allocated the necessary RAM and CPU to run the code, configurable in the lambda. We are charged based on the allocated resources and the function execution time. That's the only infrastructure we need to worry about, the rest AWS handles for us.

## Invocation Types

We can trigger lambda functions from multiple event sources, each one with different invocation types:

- **Synchronous**
  - The event is published and immediately processed (such as an HTTP request)
  - The service that triggered the event waits for the processing and handles the response
  - It determines if there was any error and if it should retry the invocation
  - Invocation type flag is **RequestResponse**
- **Asynchronous**
  - The event is published without waiting to be processed (queue or event-bus)
  - The service publishes the event to an internal queue and returns a success response with any additional information
  - A separate process reads events from the queue and runs our lambda function
  - By default, AWS Lambda sets a retry policy with **two invocation retries**
  - It's recommended to always attach a Dead-Letter Queue (DLQ) to save failed events
  - Invocation type flag is **Event**
- **Stream (event source with polling)**
  - Similar to the asynchronous model, the Lambda is **responsible for polling the events**
  - Data streams are read in **batches**, allowing us to process multiple events at once
  - The batch size is configured in the Lambda, and its limits depends on each service
  - It can be used with Amazon SQS, Amazon Kinesis and DynamoDB

## Concurrency

### Reserved concurrency

Guarantees the **maximum number** of concurrent instances for the function. When a function has reserved concurrency, no other function can use that concurrency. We can also **throttle a function** by setting the reserved concurrency to zero, stopping all executions of this function on any environment.

### Provisioned concurrency

Initializes a requested number of execution environments so that they are prepared to **respond immediately** to our functions' invocations. It comes with a cost because the function will be always warmed up, but it reduces the latency of our application.

We can also enable autoscaling with provisioned concurrency, so the Lambda can automatically allocate instances in advance when needed and free them when the peak is over.
