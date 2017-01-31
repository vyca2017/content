---
alias: ahlohd8ohn
path: /docs/reference/platform/mutation-callbacks
layout: REFERENCE
description: Mutation callbacks are a simple yet powerful event-based concept on top of GraphQL to implement custom business logic like sending emails.
tags:
  - platform
  - mutation-callbacks
  - functions
related:
  further:
    - uh8shohxie
    - ol0yuoz6go
  more:
    - saigai7cha
    - dah6aifoce
    - soiyaquah7
---

# Mutation callbacks

Mutation callbacks are a simple yet powerful concept to handle your custom business logic workflow.

An mutation callback consists of a *trigger* and a *handler*. Whenever an operation triggers the mutation callback, a custom *payload* is sent to the handler.

## Trigger

A trigger is the combination of a [model](!alias-ij2choozae) and a mutation.
Whenever this mutation is executed on the model, the mutation callback will be triggered.

> For example, if you want to trigger a mutation callback on the `User` model, the following triggers are available:
* a new user is created
* an existing user is updated
* an existing user is deleted

## Handler

An mutation callback handler is defined by an url. A post request containing the mutation callback payload is sent to this url whenever the mutation callback is triggered.

You can use [Webtask](https://webtask.io/) or [AWS Lambda](http://docs.aws.amazon.com/lambda/latest/dg/welcome.html) as mutation callbacks as a recommended choice.

Of course you can also enter an url pointing to a server that you are running yourself.

## Payload

Every mutation callback has a payload, that is sent to the handler when the mutation callback is triggered. You can define the payload with a GraphQL query on the node that is either created, updated or deleted. These are the available fields depending on the type of mutation:

* **create**:
  * *createdNode* - makes the fields of the created node available through subselection
* **update**:
  * *updatedNode* - makes the fields of the updated node available through subselection
  * *changedFields* - a list of strings with all the field names that were included as arguments of the update mutation
* **delete**:
  * *deletedNode* - makes the fields of the deleted node available through subselection

> Imagine you want to send a newsletter whenever you update one of your posts. Then you could include the post's slug and title like this:

```graphql
{
  updatedNode {
    id
    slug
    title
  }
  changedFields # this is a list of field names that were included as parameters of the update mutation
}
```

As always, you can explore the available schema in the embedded GraphiQL instance when creating an mutation callback payload.
