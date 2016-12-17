---
alias: riekooth4o
path: /docs/reference/relay-api/pagination
layout: REFERENCE
shorttitle: Pagination
description: Manage nodes in your query response in so called pages. Pagination is expressed with GraphQL query arguments.
simple_relay_twin: ojie8dohju
tags:
  - relay-api
  - queries
  - pagination
  - query-arguments
related:
  further:
    - uo6uv0ecoh
    - uu4ohnaih7
    - thaiph8ung
  more:
    - cahzai2eur
---

# Pagination in the Relay API

When querying all nodes of a specific [model](!alias-ij2choozae) you can supply arguments that allow you to paginate the query response.

Pagination allows you to request a certain amount of nodes at the same time. You can seek forwards or backwards through the nodes and supply an optional starting node:
* to seek forwards, use `first`; specify a starting node with `after`.
* to seek backwards, use `last`; specify a starting node with `before`.

You can also skip an arbitrary amount of nodes in whichever direction you are seeking by supplying the `skip` argument.

> Consider a blog where only 3 posts are shown at the front page. To query the first page:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  viewer {
    allPosts(
      first: 3
    ) {
      edges {
        node {
          id
          title
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
              "title": "My biggest Adventure"
            }
          },
          {
            "node": {
              "id": "cixnenqen38mb0134o0jp1svy",
              "title": "My latest Hobbies"
            }
          },
          {
            "node": {
              "id": "cixneo7zp3cda0134h7t4klep",
              "title": "My great Vacation"
            }
          }
        ]
      }
    }
  }
}
```

> To show the second page, we query the first 3 posts after the last one of the first page, with the id `my-post-id-3`:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  viewer {
    allPosts(
      first: 2,
      after: "cixnen24p33lo0143bexvr52n"
    ) {
      edges {
        node {
          id
          title
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
              "id": "cixnenqen38mb0134o0jp1svy",
              "title": "My latest Hobbies"
            }
          },
          {
            "node": {
              "id": "cixneo7zp3cda0134h7t4klep",
              "title": "My great Vacation"
            }
          }
        ]
      }
    }
  }
}
```

> We could reach the same result by combining `first` and `skip`:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  viewer {
    allPosts(first: 3, skip: 3) {
      edges {
        node {
          id, title
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
              "id": "my-post-id-4",
              "title": "My favorite Movies",
              "published": true
            }
          },
          {
            "node": {
              "id": "my-post-id-5",
              "title": "My favorite Actors",
              "published": true
            }
          },
          {
            "node": {
              "id": "my-post-id-6",
              "title": "My biggest Secret",
              "published": true
            }
          }
        ]
      }
    }
  }
}
```

> Query the `last` 3 posts:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  viewer {
    allPosts(last: 3) {
      edges {
        node {
          id, title
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
              "id": "my-post-id-42",
              "title": "My favorite Animals"
            }
          },
          {
            "node": {
              "id": "my-post-id-43",
              "title": "My new Work"
            }
          },
          {
            "node": {
              "id": "my-post-id-43",
              "title": "My first Post"
            }
          }
        ]
      }
    }
  }
}
```

Note: You cannot combine `first` with `before` or `last` with `after`.
Note: If you query more nodes than exist, your response will simply contain all nodes that actually do exist in that direction.
