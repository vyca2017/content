---
alias: aephaimu5n
path: /docs/reference/relay-api/filtering-by-field
layout: REFERENCE
shorttitle: Filtering
description: Use complex filter conditions to receive only the data you need. Filters are expressed by using GraphQL query arguments.
simple_relay_twin: xookaexai0
tags:
  - relay-api
  - queries
  - filters
  - query-arguments
related:
  further:
    - sa8aiwurae
    - riekooth4o
    - uo6uv0ecoh
  more:
    - cahzai2eur
---

# Filtering by field

When querying all nodes of a type you can supply different parameters to the `filter` argument to filter the query response accordingly. The available options depend on the scalar fields defined on the type in question.

You can also include filters when including related fields in your queries to [traverse your data graph](!alias-uo6uv0ecoh).

## Applying single filters

If you supply exactly one parameter to the `filter` argument, the query response will only contain nodes that fulfill this constraint.

### Filtering by value

The easiest way to filter a query response is by supplying a field value to filter by.


> Query all posts not yet published:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts(filter: {
      published: false
    }) {
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
          }
        ]
      }
    }
  }
}
```

### Advanced filter criteria

Depending on the type of the field you want to filter by, you have access to different advanced criteria you can use to filter your query response. See how to [explore available filter criteria](#explore-available-filter-criteria).

> Query all posts whose title are in a given list of titles:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts(filter: {
      title_in: ["My biggest Adventure", "My latest Hobbies"]
    }) {
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
          }
        ]
      }
    }
  }
}
```

Note: you have to supply a *list* as the `<field>_in` argument: `title_in: ["My biggest Adventure", "My latest Hobbies"]`.

### Relation filters

* For to-one relations, you can define conditions on the related node by nesting the according argument in `filter`

> Query all posts of authors with the `USER` access role

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts(filter: {
      author: {
        accessRole: USER
      }
    }) {
      edges {
        node {
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
              "title": "My biggest Adventure"
            }
          },
          {
            "node": {
              "title": "My latest Hobbies"
            }
          },
          {
            "node": {
              "title": "My great Vacation"
            }
          }
        ]
      }
    }
  }
}
```


* For to-many relations, three additional arguments are available: `every`, `some` and `none`, to define that a condition should match every, some or none related nodes.

> Query all users that have at least one published post

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allUsers(filter: {
      posts_some: {
        published: true
      }
    }) {
      edges {
        node {
          id
          posts {
            edges {
              node {
                published
              }
            }
          }
        }
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "allUsers": {
        "edges": [
          {
            "node": {
              "id": "cixnekqnu2ify0134ekw4pox8",
              "posts": {
                "edges": [
                  {
                    "node": {
                      "published": false
                    }
                  },
                  {
                    "node": {
                      "published": true
                    }
                  },
                  {
                    "node": {
                      "published": true
                    }
                  }
                ]
              }
            }
          }
        ]
      }
    }
  }
}
```

* Relation filters are also available in the nested arguments for to-one or to-many relations.

> Query all users that did not like a post of an author in the `ADMIN` access role

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allUsers(filter: {
      likedPosts_none: {
        author: {
          accessRole: ADMIN
        }
      }
    }) {
      edges {
        node {
          name
        }
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "allUsers": {
        "edges": [
          {
            "node": {
              "name": "John Doe"
            }
          },
          {
            "node": {
              "name": "Sally Housecoat"
            }
          },
          {
            "node": {
              "name": "Admin"
            }
          }
        ]
      }
    }
  }
}
```

## Combining multiple filters

You can use the filter combinators `OR` and `AND` to create an arbitrary logical combination of filter conditions.

### Using `OR` or `AND`

Let's start with an easy example:

> Query all published posts whose title are in a given list of titles:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts(filter: {
      AND: [{
        title_in: ["My biggest Adventure", "My latest Hobbies"]
      }, {
        published: true
      }]
    }) {
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
              "id": "cixnenqen38mb0134o0jp1svy",
              "title": "My latest Hobbies",
              "published": true
            }
          }
        ]
      }
    }
  }
}
```

Note: `OR` and `AND` accept a *list* as input where individual list items have to be wrapped by `{}`: `AND: [{title_in: ["My biggest Adventure", "My latest Hobbies"]}, {published: true}]`

### Arbitrary combination of filters with `AND` and `OR`

You can combine and even nest the filter combinators `AND` and `OR` to create arbitrary logical combination of filter conditions.

> Query all posts that are either published and in a list of given titles, or have the specific id we supply:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    allPosts(filter: {
      OR: [{
        AND: [{
          title_in: ["My biggest Adventure", "My latest Hobbies"]
        }, {
          published: true
        }]
      }, {
        id: "cixnen24p33lo0143bexvr52n"
      }]
    }) {
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
          }
        ]
      }
    }
  }
}
```

Note how we nested the `AND` combinator inside the `OR` combinator, on the same level with the `id` value filter.

## Explore available filter criteria

Apart from the filter combinators `AND` and `OR`, the available filter arguments for a query for all nodes of a type depend on the fields of the type and their types. To explore the available filters, use the playground and its documentation and auto-completion features.
