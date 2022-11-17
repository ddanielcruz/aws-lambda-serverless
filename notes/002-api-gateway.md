# API Gateway

API Gateway is a **fully managed service** for developers to create, publish, maintain, monitor and secure APIs at any scale. It's the front door for applications to access backend services and business logic (our lambdas) on AWS.

We can use it to create **RESTful** and **Websocket** APIs. The first optimized for serverless workloads and HTTP backends (microservices) and the second one for real-time two way communication.

Its **architecture** handles all tasks in accepting and processing hundreds of thousands of concurrent API calls, such as traffic management, authorization and access control, monitoring, API versioning and others. Our only concern is building our backend and easily exposing it with API gateway.

## API Types

We can build three types of APIs using API gateway:

- **HTTP APIs**
  - Used to create RESTful APIs with **lower latency and cost** than REST APIs
  - Composed of HTTP methods and resources configured in the API gateway
  - Preferred for microservices applications
- **REST APIs**
  - Same as HTTP APIs, but with [additional features](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-vs-rest.html) handled by API gateway
  - It's more expensive and a bit slower because of the additional processing
  - Picking one or another depends on the application, but this is the preferred option for most of them because of all its features and capabilities
- **WebSocket APIs**
  - Implement real-time communication between client and server
  - API gateway handles the connection between the client and our lambdas
