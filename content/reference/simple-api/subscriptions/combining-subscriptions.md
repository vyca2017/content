---
alias: kengor9ei3
path: /docs/reference/simple-api/combining-subscriptions
layout: REFERENCE
shorttitle: Combining Subscriptions
description: You can combine multiple GraphQL subscriptions and use the advanced filter system relying on GraphQL query arguments for additional control.
simple_relay_twin: eih4eew7re
tags:
  - simple-api
  - subscriptions
related:
  further:
    - bag3ouh2ii
    - oe8oqu8eis
    - ohmeta3pi4
---

# Combining Subscriptions

You can subscribe to multiple mutations on the same model in one subscription.

## Subscribe to all Changes to all Nodes

Using the `mutation_in` argument of the `filter` object, you can select the type of mutation that you want to subscribe on. For example, to subscribe to the `createPost`, `updatePost` and `deletePost` mutations:

```graphql
subscription changedPost {
  Post(
    filter: {
      mutation_in: [CREATED, UPDATED, DELETED]
    }
  ) {
    mutation
    node {
      id
      description
    }
    updatedFields
    previousValues {
      description
      imageUrl
    }
  }
}
```

## Subscribe to all Changes to specific Nodes

To select specific nodes that you want to be notified about, use the `node` argument of the `filter` object. You can combine it with `mutation_in`. For example, to only be notified of created, updated and deleted posts if a specific user follows the author:

```graphql
subscription changedPost {
  Post(
    filter: {
      mutation_in: [CREATED, UPDATED, DELETED]
      node: {
        author: {
          followedBy_some: {
            id: "some-user-id"
          }
        }
      }
    }
  ) {
    mutation
    node {
      id
      description
    }
    updatedFields
    previousValues {
      description
      imageUrl
    }
  }
}
```

> Note: `previousValues` is `null` for `CREATED` subscriptions and `updatedFields` is `null` for `CREATED` and `DELETED` susbcriptions.

## Advanced Subscription Filters

You can make use of a similar [filter system as for queries](!alias-xookaexai0) using the `filter` argument.

For example, you can subscribe to all `CREATED` and `DELETE` susbcriptions, as well as all `UPDATED` subscriptions when the `imageUrl` was updated

```graphql
subscription changedPost {
  Post(
    filter: {
      OR: [{
        mutation_in: [CREATED, DELETED]
      }, {
        mutation_in: [UPDATED]
        updatedFields_contains: "imageUrl"
      }]
    }
  ) {
    mutation
    node {
      id
      description
    }
    updatedFields
    previousValues {
      description
      imageUrl
    }
  }
}
```

> Note: Using any of the `updatedFields` filter conditions together with `CREATED` or `DELETED` subscriptions results in an error.

> Note: `previousValues` is `null` for `CREATED` subscriptions and `updatedFields` is `null` for `CREATED` and `DELETED` susbcriptions.
