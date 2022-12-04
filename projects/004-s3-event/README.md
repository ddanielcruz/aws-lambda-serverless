# Infrastructure

The infrastructure part of the project was made on AWS Console application, and here are the steps to reproduce:

1. Create a new **S3 bucket** without changing any configuration
2. Create a new **Lambda function** with read-only permission to Amazon S3 and basic permission to DynamoDB
   1. Policy templates are **Simple microservice permissions** and **Amazon S3 object read-only permissions**
3. With the function created, click on **Add trigger** to specify how the function will be invoked
4. Select S3 option to trigger the function, select the bucket you created and set event type to **PUT**
5. Next step is creating a **DynamoDB table** with following config:
   1. Partition key to **key** as string
   2. Provisioning set to **On-Demand**
