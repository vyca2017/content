---
alias: vequoog7hu
path: /docs/reference/simple-api/ordering-by-field
layout: REFERENCE
shorttitle: Ordering
description: Define the sort order of nodes in your query response with a GraphQL query argument.
simple_relay_twin: sa8aiwurae
tags:
  - simple-api
  - queries
  - query-arguments
  - order-by
related:
  further:
    - koo4eevun4
    - pa2aothaec
    - aihaeph5ip
  more:
    - cahzai2eur
---

# Ordering by field

When querying all nodes of a [type](!alias-ij2choozae) you can supply the `orderBy` argument for every scalar field of the type: `orderBy: <field>_ASC` or `orderBy: <field>_DESC`.

> Order the list of all posts ascending by title:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts(orderBy: title_ASC) {
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
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation",
        "published": true
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies",
        "published": true
      }
    ]
  }
}
```

> Order the list of all posts descending by published:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts(orderBy: published_DESC) {
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
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies",
        "published": true
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation",
        "published": true
      },
      {
        "id": "cixnen24p33lo0143bexvr52n",
        "title": "My biggest Adventure",
        "published": false
      }
    ]
  }
}
```

Note: The field you are ordering by does not have to be selected in the actual query.
Note: If you do not specify an ordering, the response is implicitely ordered ascending by the `id` field

## Limitations

It's currently not possible to order responses [by multiple fields](https://github.com/graphcool/feature-requests/issues/62) or [by related fields](https://github.com/graphcool/feature-requests/issues/95). Join the discussion in the feature requests if you're interested in these features!
