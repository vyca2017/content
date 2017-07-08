# Traversing One Node in the Simple API

Traversing edges that connect the current node to the one side of a relation can be done by simply selecting the according field defined with the relation.

> Query information on the author node connected to a specific post node:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  Post(id: "cixnen24p33lo0143bexvr52n") {
    id
    author {
      id
      name
      email
    }
  }
}
---
{
  "data": {
    "Post": {
      "id": "cixnen24p33lo0143bexvr52n",
      "author": {
        "id": "cixnekqnu2ify0134ekw4pox8",
        "name": "John Doe",
        "email": "john.doe@example.com"
      }
    }
  }
}
```

Note: You can add filter query arguments to an inner field returning a single node.
