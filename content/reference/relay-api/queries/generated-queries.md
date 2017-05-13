---
alias: oiviev0xi7
path: /docs/reference/relay-api/queries
layout: REFERENCE
description: Use queries to fetch data. Queries in the GraphQL schema of your project are derived from types and relations that you defined.
simple_relay_twin: nia9nushae
tags:
  - relay-api
  - queries
related:
  further:
    - vah0igucil
    - aizoong9ah
  more:
    - cahzai2eur
---

# Queries in the Relay API

A *query* enables you to declare data requirements in your app by supplying multiple [fields](!alias-teizeit5se).
All queries are automatically generated. To explore them, use the [playground](!alias-oe1ier4iej) inside your project.

After you send a query to your [endpoint](!alias-yahph3foch#project-endpoints) you will receive the *query response*. It contains the actual data for all fields that were specified in the query.

This is an example query:

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

There are different categories of generated queries. Depending on the query category, different *query arguments* are available that allow you to further modify the query response.

## Querying one node

For each [type](!alias-ij2choozae) in your project there is a query to fetch [one specific node](!alias-ga4chied8m) of that type.

## Querying multiple nodes

For each [type](!alias-ij2choozae) in your project there is a query to fetch [multiple nodes](!alias-uu4ohnaih7) of that type.

## Session user

To get more information on the currently signed in user, there is a query for the [session user](!alias-peyaaph9vi)
