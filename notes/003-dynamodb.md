# DynamoDB

Amazon DynamoDB is a fully managed **NoSQL database** service that provides **fast** and **predictable** performance with seamless scalability. It was designed to run high-performance applications at any scale, serving any level of request traffic.

It has basic concepts as other databases, such as tables/collections, items/rows and attributes/columns, with the difference that it does not require a complete schema for the table items. We need to define only the indexes schema to uniquely identify the items in the table, but the items can contain any other information we need without defining a schema.

## Keys

- Primary key: uniquely identifies each item in the table; it always has a **partition key** and it might also have a **sort key**
- Partition key: simple PK, composed of one attribute known as the partition key; each value must be unique;
- With Sort key: referred to as composite PK; the first attribute is the part. key used and second one is the sort key; partition key can be duplicated in this scenario, but the sort key must be unique;

Each table is stored in a **partition**, an allocation of storage backed by SSD drivers and automatically replicated across multiple availability zones. Dynamo allocates sufficient partitions for the table to handle provisioned **throughput requirements**. This partition management process is automatically.

When using only a partition key, Dynamo hashes the received key and stores each item on one of the partitions. When using a composite key, the hash is also calculated, but items are stored physically together for faster access, and ordered by the sort key value.

## Availability

Dynamo is available in multiple AWS regions around the world. Each region is independent and isolated, protected from failures on other zones. When our application writes data to a table, the data is **eventually** consistent across all storage locations. Dynamo supports **eventually consistent reads** and **strongly/strict consistent reads**.

### CAP Theorem

The [CAP theorem](https://www.bmc.com/blogs/cap-theorem/) is a belief from theoretical computer science about distributed data stores. It proves a distributed system can't have **consistency**, **availability** and **partitioning** all at the same time, that one of them needs to be sacrificed.

Partitioning is a must for distributed systems, so the choice is between the other two. In summary, if our system requires **high availability** whenever we read data from a partition we'll get a response, but this response may not be the latest version, because some write on another partition/replica is still being propagated. On another hand, if our system requires **consistency**, our read operation might be blocked or it might fail because the write is not complete, so our system wouldn't have availability.

Most microservices architectures choose partitioning with high availability and eventual consistency. The data will become consistent after a certain time, but it does not guarantee instant consistency. According to CAP theorem, we need to consider the consistency level we need, being **strict consistency** when the data should be changed and immediately propagated to every client (slower) or **eventual consistency**, with data taking some time to be propagated across all partitions.
