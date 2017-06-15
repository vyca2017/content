---
alias: aihaeph5ip
path: /docs/reference/simple-api/traverse-the-graph
layout: REFERENCE
shorttitle: Traversing the data graph
description: Traverse nodes in your query response by using edges. Available edges in the GraphQL schema depend on types and relations in your backend.
simple_relay_twin: uo6uv0ecoh
tags:
  - simple-api
  - queries
  - edges
  - relations
related:
  further:
    - ua6eer7shu
    - pa2aothaec
    - goh5uthoc1
  more:
    - tioghei9go
    - cahzai2eur  
    - ahwoh2fohj
---

# Traversing the data graph with the Simple API

You can traverse the data graph in a query by including the field of a specific [relation](!alias-goh5uthoc1) and adding nested fields inside the now selected node.

Consider the following project setup: the `Post` and `User` types are related via the `author` and `posts` fields. Any query for posts will expose the `user` field, and any query for users will expose the `posts` field.

## Traversing a one-to-one edge

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

## Traversing a one-to-many or many-to-many edge

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

## Meta data for edges

Nodes connected to multiple nodes via a one-to-many or many-to-many edge expose the `_edgeMeta` field that can be used to query meta information of a connection rather then the actual connected nodes.

> Query meta information on the post nodes of a certain author node:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  User(id: "cixnekqnu2ify0134ekw4pox8") {
    id
    name
    _postsMeta {
      count
    }
  }
}
---
{
  "data": {
    "User": {
      "id": "cixnekqnu2ify0134ekw4pox8",
      "name": "John Doe",
      "_postsMeta": {
        "count": 3
      }
    }
  }
}
```
