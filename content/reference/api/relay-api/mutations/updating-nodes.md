---
alias: uath8aifo6
path: /docs/reference/relay-api/updating-nodes
layout: REFERENCE
shorttitle: Updating nodes
description: Updates fields of an existing node in your GraphQL backend. The node fields will be updated according to the provided values.
simple_relay_twin: cahkav7nei
tags:
  - relay-api
  - mutations
  - nodes
related:
  further:
    - oodoi6zeit
    - oojie3ooje
    - thaiph8ung
  more:
    - cahzai2eur
    - dah6aifoce
---


# Updating nodes

Updates [fields](!alias-teizeit5se) of an existing node of a certain [type](!alias-ij2choozae) specified by the `id` field.
The node's fields will be updated according to the additionally provided values.

The query response can contain all fields of the updated node.

> Update the text and published fields for existing post and query its id:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  updatePost(input: {
    id: "cixnen24p33lo0143bexvr52n",
    text: "This is the start of my biggest adventure!",
    published: true,
    clientMutationId: "abc"
  }) {
    post {
      id
    }
  }
}
---
{
  "data": {
    "updatePost": {
      "post": {
        "id": "cixnen24p33lo0143bexvr52n"
      }
    }
  }
}
```
