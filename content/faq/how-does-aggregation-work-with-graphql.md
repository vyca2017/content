---
alias: eip2ophoof
path: /docs/faq/aggregation-in-graphql
layout: FAQ
description: Aggregation functions can be used to compile information across your dataset. Learn how aggregation works in GraphQL.
tags:
  - queries
  - client-apis
  - platform
related:
  further:
    - xookaexai0
  more:
  - shu9xee3ou
---

# How Does Aggregation Work In GraphQL?

Aggregation functions can be used to compile information across your dataset.

## Aggregation in the Simple API

Aggregation in the Simple API is exposed using so called meta fields. Let's query all movies, the number of actors by movie and the total number of movies:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query {
  allMovies {
    title
    _actorsMeta {
      count
    }
  }
  _allMoviesMeta(filter: {
    title_starts_with: "The Dark"
  }) {
    count
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "title": "Inception",
        "_actorsMeta": {
          "count": 5
        }
      },
      {
        "title": "The Dark Knight",
        "_actorsMeta": {
          "count": 7
        }
      },
      {
        "title": "Batman Begins",
        "_actorsMeta": {
          "count": 6
        }
      },
      {
        "title": "The Dark Knight Rises",
        "_actorsMeta": {
          "count": 8
        }
      }
    ],
    "_allMoviesMeta": {
      "count": 2
    }
  }
}
```

* using `_allMoviesMeta`, we count movies that match certain conditions. The `filter` argument works identical to [filters on normal queries](!alias-xookaexai0).
* using `_actorsMeta`, we count the actors per movie.

## Aggregation in the Relay API

Aggregation in the Simple API is exposed using so called meta fields. Let's query all movies, the number of actors by movie and the total number of movies:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query {
  viewer {
    allMovies {
      edges {
        node {
          title
          actors {
            count
          }
        }
      }
      count
    }
	}
}
---
{
  "data": {
    "viewer": {
      "allMovies": {
        "edges": [
          {
            "node": {
              "title": "Inception",
              "actors": {
                "count": 5
              }
            }
          },
          {
            "node": {
              "title": "The Dark Knight",
              "actors": {
                "count": 7
              }
            }
          },
          {
            "node": {
              "title": "Batman Begins",
              "actors": {
                "count": 6
              }
            }
          },
          {
            "node": {
              "title": "The Dark Knight Rises",
              "actors": {
                "count": 8
              }
            }
          }
        ],
        "count": 4
      }
    }
  }
}
```

* using `count` on the `allMovies` connection, we count movies.
* using `count` on the `actors` connection, we count the actors per movie.

If you have a suggestion for additional aggregation functions, join [the discussion on GitHub](https://github.com/graphcool/feature-requests/issues/70)!
