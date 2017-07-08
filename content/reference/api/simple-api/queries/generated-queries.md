---
alias: nia9nushae
path: /docs/reference/simple-api/queries
layout: REFERENCE
description: A GraphQL query is used to fetch data from a GraphQL endpoint.
simple_relay_twin: oiviev0xi7
tags:
  - simple-api
  - queries
related:
  further:
    - ol0yuoz6go
  more:
    - cahzai2eur
---

# Queries in the Simple API

A *GraphQL query* is used to fetch data from a GraphQL [endpoint](!alias-yahph3foch#project-endpoints). This is an example query:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts {
    id
    title
    published
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n",
        "title": "My biggest Adventure",
        "published": false
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies",
        "published": true
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation",
        "published": true
      }
    ]
  }
}
```

Different queries are available:

* For every [type](!alias-ij2choozae) in your [GraphQL schema](!alias-ahwoh2fohj), so called type queries will be generated to fetch [single](!alias-ua6eer7shu) or [multiple nodes](!alias-pa2aothaec) for that type.
* Queries can be used to [traverse the data graph](!alias-aihaeph5ip) whenever there's a [relation](!alias-goh5uthoc1).
* Some queries support [query arguments](!alias-ohrai1theo) to further control the query response.
* A special query to get more information on [an authenticated user](!alias-gieh7iw2ru) is available.

To explore the available queries, use the [playground](!alias-oe1ier4iej) inside your project.
