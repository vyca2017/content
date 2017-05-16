---
alias: pa6guruhaf
path: /docs/reference/functions/request-pipeline/overview
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
tags:
  - functions
related:
  further:
  more:
---

# Request Pipeline

Every request that reaches your API goes through different stages that are collectively referred to as the *request pipeline*. Using functions, you can run **data transformation and validation** operations at different hook points along the request.

## Trigger

The trigger of the request pipeline associates the Request Pipeline function with a [create, update or delete mutation](!alias-ol0yuoz6go) of a specific [type](!alias-ij2choozae).

## Request Lifecycle

Every request to the GraphQL APIs pass several execution layers. The request pipeline allows you to **transform and validate data** as well as **prevent a request from reaching the next layer**, effectively aborting the request.

![](./hook-points.png)

### Execution Layers

The different **execution layers** can be seen in the above diagram.

* First, the raw HTTP request hits your API layer.
* The embedded GraphQL mutation is validated against the [GraphQL schema](!alias-ahwoh2fohj) in the **schema validation** step
* A valid GraphQL mutation is checked against [defined constraints](!alias-teizeit5se#field-constraints) and the [permission system](!alias-iegoo0heez) in the **data validation** step.
* If the request contained a valid mutation in terms of the GraphQL schema as well as the constraints and permissions, data is written to the database in the **data write** step.
* The mutation payload is sent back as response to the initial HTTP request.

### Hook Points

In between the execution layers, you can use functions at several **hook points**:

* The [`TRANSFORM_ARGUMENT` hook point](!alias-caich7oeph) after the schema validation allows you to **transforms the input arguments** of the GraphQL mutations and **enforce custom constraints**.
* The [`PRE_WRITE` hook point](!alias-phe1gei6io) after the data validation gives you the chance to **commmunicate with external APIs and services** before data is actually written to the database.
* After the successful extraction of the GraphQL operations from the raw request, the **data validation** layer checks predefined constraints and permissions.
* The [`TRANSFORM_PAYLOAD` hook point](!alias-ecoos0ait6) allows you **transform the payload** that is sent back as response.

> For a given trigger, only **one function** can be assigned to each hook point.
