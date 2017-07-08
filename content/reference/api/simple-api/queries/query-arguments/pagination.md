---
alias: ojie8dohju
path: /docs/reference/simple-api/pagination
layout: REFERENCE
shorttitle: Pagination
description: Manage nodes in your query response in so called pages. Pagination is expressed with GraphQL query arguments.
simple_relay_twin: riekooth4o
tags:
  - simple-api
  - queries
  - pagination
  - query-arguments
related:
  further:
    - aihaeph5ip
    - pa2aothaec
    - koo4eevun4
  more:
    - cahzai2eur
---

# Pagination

When querying all nodes of a specific [type](!alias-ij2choozae) you can supply arguments that allow you to paginate the query response.

Pagination allows you to request a certain amount of nodes at the same time. You can seek forwards or backwards through the nodes and supply an optional starting node:
* to seek forwards, use `first`; specify a starting node with `after`.
* to seek backwards, use `last`; specify a starting node with `before`.

You can also skip an arbitrary amount of nodes in whichever direction you are seeking by supplying the `skip` argument.

Note that **a maximum of 1000 nodes* can be returned per pagination field. If you need to query more nodes than that, you can use `first` and `skip` to seek through the different pages. You can also include multiple versions of the same field with different pagination parameters in one query.

> Consider a blog where only 3 posts are shown at the front page. To query the first page:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  allPosts(first: 3) {
    id
    title
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n",
        "title": "My biggest Adventure"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation"
      }
    ]
  }
}
```

> To query the first two posts after the first post:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  allPosts(
    first: 2
    after: "cixnen24p33lo0143bexvr52n"
  ) {
    id
    title
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation"
      }
    ]
  }
}
```

> We could reach the same result by combining `first` and `skip`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  allPosts(
    first: 2
    skip: 1
  ) {
    id
    title
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation"
      }
    ]
  }
}
```

> Query the `last` 2 posts:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  allPosts(last: 2) {
    id
    title
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "title": "My latest Hobbies"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "title": "My great Vacation"
      }
    ]
  }
}
```

Note: You cannot combine `first` with `before` or `last` with `after`.
Note: If you query more nodes than exist, your response will simply contain all nodes that actually do exist in that direction.
