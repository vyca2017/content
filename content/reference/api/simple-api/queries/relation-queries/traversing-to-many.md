# Traversing Many Nodes in the Simple API

In the Simple API, traversing edges connecting the current node to the many side of a relation works the same as for a one side of a relation. Simply select the relation field.

> Query information on all post nodes of a certain author node:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  User(id: "cixnekqnu2ify0134ekw4pox8") {
    id
    name
    posts {
      id
      published
    }
  }
}
---
{
  "data": {
    "User": {
      "id": "cixnekqnu2ify0134ekw4pox8",
      "name": "John Doe",
      "posts": [
        {
          "id": "cixnen24p33lo0143bexvr52n",
          "published": false
        },
        {
          "id": "cixnenqen38mb0134o0jp1svy",
          "published": true
        },
        {
          "id": "cixneo7zp3cda0134h7t4klep",
          "published": true
        }
      ]
    }
  }
}
```

Note: Query arguments for an inner field returning multiple nodes work exactly the same as query arguments for queries [returning multiple nodes](!alias-pa2aothaec).
