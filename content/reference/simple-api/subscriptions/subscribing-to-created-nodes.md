---
alias: oe8oqu8eis
path: /docs/reference/simple-api/subscribing-to-created-nodes
layout: REFERENCE
shorttitle: Subscribing to Created Nodes
description: For a given model, you can subscribe to all successfully created nodes using the generated model subscription.
simple_relay_twin: eih4eew7re
tags:
  - simple-api
  - subscriptions
related:
  further:
    - bag3ouh2ii
    - ohmeta3pi4
    - kengor9ei3
---

# Subscribing to Created Nodes

For a given model, you can subscribe to all successfully created nodes using the generated model subscription.

## Subscribe to all Created Nodes

If you want to subscribe to created nodes of the `Post` model, you can use the `Post` subscription and specify the `filter` object and set `mutation_in: [CREATED]`.

```graphql
subscription createPost {
  Post(
    filter: {
      mutation_in: [CREATED]
    }
  ) {
    mutation
    node {
      description
      imageUrl
      author {
        id
      }
    }
  }
}
```

The payload contains

* `mutation`: in this case it will return `CREATED`
* `node`: allows you to query information on the created node and connected nodes

## Subscribe to Specific Created Nodes

You can make use of a similar [filter system as for queries](!alias-xookaexai0) using the `node` argument of the `filter` object.

For example, to only be notified of a created post if a specific user follows the author:

```graphql
subscription followedAuthorCreatedPost {
  Post(
    filter: {
      mutation_in: [CREATED]
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
      description
      imageUrl
      author {
        id
      }
    }
  }
}
```
