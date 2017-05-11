# Request Pipeline

Every request that reaches your API goes through different stages that are collectively referred to as the *request pipeline*. Using functions, you can run **data transformation and validation** operations at different hook points along the request.

## Hook Points

![](./hook-points.png)

Every request to the GraphQL APIs pass several execution layers. The request pipeline allows you to **transform and validate data** as well as **prevent a request from reaching the next layer**, effectively aborting the request.

* First, the raw HTTP request hits your API layer.
* In the **schema validation** layer, the request is then validated against your GraphQL schema and the GraphQL operations are extracted.
* At this point, you can define a function that [transforms input arguments of GraphQL operations]() and enforces custom constraints.
* After the successful extraction of the GraphQL operations from the raw request, the **data validation** layer checks predefined constraints and permissions.
* Now, [before data is written to the database](), you have the chance to interact with external services or prevent the **data write** after all.
* After the database action finished, you can [transform the GraphQL response]().

## Transformations and Error Handling

* transformations
* [error handling]()
