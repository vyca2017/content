---
alias: viez1oosek
path: /docs/faq/cursor-based-pagination-with-graphql
layout: FAQ
description: Cursor-based pagination is a common pattern in GraphQL to display content in equally sized pages that allow forward and backward navigation.
tags:
  - graphql
  - queries
  - pagination
  - client-apis
related:
  further:
    - pa2aothaec
    - aihaeph5ip
    - ojie8dohju
  more:
    - cae2ahz0ne
    - aing7uech3
---

# Cursor-based Pagination with GraphQL

When dealing with long lists of data, a typical form of presenting this is using different pages. The user can navigate back and forth to browse the content and focus on a small subset of the complete list. In GraphQL, cursor-based pagination is a common pattern to handle situations like that.

## Cursor Identification Based On Ids

Let's explore how cursor-based pagination works for a list of movies:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query {
  allMovies {
    id
    title
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "id": "cixos5gtq0ogi0126tvekxo27",
        "title": "Inception"
      },
      {
        "id": "cixxhjs04pm0h015815qnrkyu",
        "title": "The Dark Knight"
      },
      {
        "id": "cixxhneo4qd4e01503f08d2hc",
        "title": "Batman Begins"
      },
      {
        "id": "cixxhupwksrq50150i50j3lha",
        "title": "The Dark Knight Rises"
      }
    ]
  }
}
```

A cursor is simply a reference to a specific node. In our case we are paginating movies, so we can use any movie id. Let's choose the movie "The Dark Knight", so the id is "cixxhjs04pm0h015815qnrkyu".

## Seeking Forwards and Backwards

Now we can use the `first` argument in combination with `after`, to query the first movie after "The Dark Knight":

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query nextMovie {
  allMovies(
    first: 1
    after: "cixxhjs04pm0h015815qnrkyu"
  ) {
    id
    title
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "id": "cixxhneo4qd4e01503f08d2hc",
        "title": "Batman Begins"
      }
    ]
  }
}
```

As we can confirm in the initial query, the next movie is "Batman Begins". We can also browse through the content backwards! This is accomplished by combining `last` with `before`. The last movie before "The Dark Knight" is "Inception". Let's make sure with this query:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query previousMovie {
  allMovies(
    last: 1
    before: "cixxhjs04pm0h015815qnrkyu"
  ) {
    id
    title
  }
}
---
{
  "data": {
    "after": [
      {
        "id": "cixos5gtq0ogi0126tvekxo27",
        "title": "Inception"
      }
    ]
  }
}
```

## Pagination Combined with Ordering and Filtering

Paginating both forwards and backwards works seamlessly in combination with ordering and filtering. Let's order the movies by title first:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query all {
  allMovies(orderBy: title_ASC) {
    id
    title
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "id": "cixxhneo4qd4e01503f08d2hc",
        "title": "Batman Begins"
      },
      {
        "id": "cixos5gtq0ogi0126tvekxo27",
        "title": "Inception"
      },
      {
        "id": "cixxhjs04pm0h015815qnrkyu",
        "title": "The Dark Knight"
      },
      {
        "id": "cixxhupwksrq50150i50j3lha",
        "title": "The Dark Knight Rises"
      }
    ]
  }
}
```

Now let's query for the second movie after "Batman Begins" whose *title starts with "The Dark"*. We can query the second instead of the first movie by adding `skip: 1`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query secondDarkMovie {
  allMovies(
    orderBy: title_ASC
    first: 1
    after: "cixxhneo4qd4e01503f08d2hc"
    skip: 1
    filter: {
      title_starts_with: "The Dark"
    }
  ) {
    id
    title
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "id": "cixxhupwksrq50150i50j3lha",
        "title": "The Dark Knight Rises"
      }
    ]
  }
}
```

## Querying the Surrounding Nodes

By combining the query using `first` and `after` with a query using `last` and `before` we can query the surrounding movies of a specific movie:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query movieTriple($middleId: ID!, $middleCursor:String!){
  before: allMovies(
    last: 1
    before: $middleCursor
  ) {
    ... movieDetails
  }
  middle: allMovies(filter: {
    id: $middleId
  }) {
    ... movieDetails
  }
  after: allMovies(
    first: 1
    after: $middleCursor
  ) {
    ... movieDetails
  }
}

fragment movieDetails on Movie {
  id
  title
}
---
{
  "middleId": "cixxhjs04pm0h015815qnrkyu",
  "middleCursor": "cixxhjs04pm0h015815qnrkyu"
}
---
{
  "data": {
    "before": [
      {
        "id": "cixos5gtq0ogi0126tvekxo27",
        "title": "Inception"
      }
    ],
    "middle": [
      {
        "id": "cixxhjs04pm0h015815qnrkyu",
        "title": "The Dark Knight"
      }
    ],
    "after": [
      {
        "id": "cixxhneo4qd4e01503f08d2hc",
        "title": "Batman Begins"
      }
    ]
  }
}
```

Note that by using GraphQL fragments we also don't need to state the same data dependencies multiple times.
