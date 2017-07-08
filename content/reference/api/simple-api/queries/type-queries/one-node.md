---
alias: ua6eer7shu
path: /docs/reference/simple-api/one-node
layout: REFERENCE
shorttitle: Fetch one node
description: Query one node by specifying a unique field such as its id.
simple_relay_twin: ga4chied8m
tags:
  - simple-api
  - queries
  - nodes
related:
  further:
    - teizeit5se
    - iegoo0heez
    - koo4eevun4
    - aihaeph5ip
  more:
    - cahzai2eur
    - tioghei9go
    - ier7sa3eep
---

# Fetch One Node in the Simple API

For each [type](!alias-ij2choozae) in your project, the Simple API provides an automatically generated query to fetch one specific node of that type. To specify the node, all you need to provide is its `id` or another unique field.

For example, for the type called `Post` a top-level query `Post` will be generated.

## Specifying the node by id

You can always use the [system field](!alias-uhieg2shio#id-field) `id` to identify a node.

> Query a specific post by id:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  Post(id: "cixnen24p33lo0143bexvr52n") {
    id
    title
    published
  }
}
---
{
  "data": {
    "Post": {
      "id": "cixnen24p33lo0143bexvr52n",
      "title": "My biggest Adventure",
      "published": false
    }
  }
}
```

## Specifying the node by another unique field

You can also supply any [unique field](!alias-teizeit5se#unique) as an argument to the query to identify a node. For example, if you already declared the `slug` field of the `Post` type to be unique, you could select a post by specifying its slug:

> Query a specific node by slug:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  Post(slug: "my-biggest-adventure") {
    id
    slug
    title
    published
  }
}
---
{
  "data": {
    "Post": {
      "id": "cixnen24p33lo0143bexvr52n",
      "slug": "my-biggest-adventure",
      "title": "My biggest Adventure",
      "published": false
    }
  }
}
```

Note: You cannot specify two or more unique arguments for one query at the same time.
