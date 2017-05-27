---
alias: oojie3ooje
path: /docs/reference/relay-api/deleting-nodes
layout: REFERENCE
shorttitle: Deleting nodes
description: Deletes a node in your GraphQL backend. The query response can contain all fields of the deleted node.
simple_relay_twin: fasie2rahv
tags:
  - relay-api
  - mutations
related:
  further:
    - oodoi6zeit
    - uath8aifo6
    - thaiph8ung
  more:
    - cahzai2eur
    - dah6aifoce
---

# Deleting nodes

Deletes a node specified by the `id` field.

The query response can contain all scalar fields of the deleted node.

> Delete an existing post and query its id and title:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  deletePost(input: {
    id: "cixp00vkv069v0156d9xxtjbw"
    clientMutationId: "abc"
  }) {
    deletedId
    post {
      id
      title
    }
  }
}
---
{
  "data": {
    "deletePost": {
      "deletedId": "cixp00vkv069v0156d9xxtjbw",
      "post": {
        "id": "cixp00vkv069v0156d9xxtjbw",
        "title": "delete me"
      }
    }
  }
}
```

> Note: it's not possible to [query related fields as part of delete mutations](https://github.com/graphcool/feature-requests/issues/108).
