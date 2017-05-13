---
alias: uu4ohnaih7
path: /docs/reference/relay-api/multiple-nodes
layout: REFERENCE
shorttitle: Querying multiple nodes
description: Query all nodes of a type and combine filter, order and pagination query arguments to exactly define what data you want to fetch.
simple_relay_twin: pa2aothaec
tags:
  - relay-api
  - queries
  - nodes
related:
  further:
    - sa8aiwurae
    - ga4chied8m
    - thaiph8ung
    - aephaimu5n
    - riekooth4o
  more:
    - cahzai2eur
    - tioghei9go
---

# Querying multiple nodes in the Relay API

The Relay API contains automatically generated queries to fetch all nodes of a certain [type](!alias-ij2choozae). For example, for the `Post` type the query `allPosts` will be generated that is available through the `viewer`.

## Querying all nodes of a specific type

> Query all post nodes:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts {
      edges {
        node {
          id
          title
          published
        }
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "allPosts": {
        "edges": [
          {
            "node": {
              "id": "cixnen24p33lo0143bexvr52n",
              "title": "My biggest Adventure",
              "published": false
            }
          },
          {
            "node": {
              "id": "cixnenqen38mb0134o0jp1svy",
              "title": "My latest Hobbies",
              "published": true
            }
          },
          {
            "node": {
              "id": "cixneo7zp3cda0134h7t4klep",
              "title": "My great Vacation",
              "published": true
            }
          }
        ]
      }
    }
  }
}
```

> A few examples for query names
* type name: `Post`, query name: `allPosts`
* type name: `Todo`, query name: `allTodoes`
* type name: `Hobby`, query name: `allHobbies`.

Note: The query name approximate the plural rules of the English language. If you are unsure about the actual query name, explore available queries in your [playground](!alias-oe1ier4iej).

## Modifying the query response

The query response of a query fetching multiple nodes can be further controlled by supplying different query arguments. The response can be

* [ordered by field](!alias-sa8aiwurae)
* [filtered by multiple fields](!alias-aephaimu5n)
* [paginated](!alias-riekooth4o) into multiple pages by fixing one specific node and either seeking forwards or backwards

These query arguments can be combined to achieve very specific query responses.
