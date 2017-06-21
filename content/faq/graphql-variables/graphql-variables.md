---
alias: thaexex7av
path: /docs/faq/flexibility-and-control-with-graphql-variables
layout: FAQ
preview: graphql-variables.png
description: GraphQL variables extend queries and mutations to be more flexible and can be used for simple scalar values, enums or input object types.
tags:
  - graphql
  - variable
  - queries
  - mutations
related:
  further:
    - ol0yuoz6go
    - nia9nushae
    - teizeit5se
  more:
    - moach1gich
---

# Flexibility And Control With GraphQL Variables

GraphQL variables extend queries and mutations to be **dynamic and more flexible**. They can be used for simple *scalar* values, as well as *enums* or *input object types*. Additionally they work very well together with [GraphQL directives](!alias-moach1gich).

Using GraphQL variables is the preferred way to construct a query dynamically, as you don't need complex string interpolations and escaping. We're exploring GraphQL variables using a schema with movies and actors:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query moviesAndActors {
  allMovies {
    title
    actors(first: 3) {
      name
    }
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "title": "Inception",
        "actors": [
          {
            "name": "Leonardo DiCaprio"
          },
          {
            "name": "Ellen Page"
          },
          {
            "name": "Tom Hardy"
          }
        ]
      },
      {
        "title": "The Dark Knight",
        "actors": [
          {
            "name": "Christian Bale"
          },
          {
            "name": "Heath Ledger"
          },
          {
            "name": "Aaron Eckhart"
          }
        ]
      },
      {
        "title": "Batman Begins",
        "actors": [
          {
            "name": "Christian Bale"
          },
          {
            "name": "Michael Caine"
          },
          {
            "name": "Gary Oldman"
          }
        ]
      },
      {
        "title": "The Dark Knight Rises",
        "actors": [
          {
            "name": "Tom Hardy"
          },
          {
            "name": "Joseph Gordon-Levitt"
          },
          {
            "name": "Marion Cotillard"
          }
        ]
      }
    ]
  }
}
```

We are fetching the title of all movies as well as the first three actors of each movie. Let's see how we can adjust the number of fetched authors using a GraphQL variable.

## Using GraphQL Variables For Dynamic Queries

Let's introduce a variable for the number of actors we want to query for each movie:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: false
---
query moviesAndActors($firstActors: Int) {
  allMovies {
    title
    actors(first: $firstActors) {
      name
    }
  }
}
---
{
  "firstActors": 3
}
---
{
  "data": {
    "allMovies": [
      {
        "title": "Inception",
        "actors": [
          {
            "name": "Leonardo DiCaprio"
          },
          {
            "name": "Ellen Page"
          },
          {
            "name": "Tom Hardy"
          }
        ]
      },
      {
        "title": "The Dark Knight",
        "actors": [
          {
            "name": "Christian Bale"
          },
          {
            "name": "Heath Ledger"
          },
          {
            "name": "Aaron Eckhart"
          }
        ]
      },
      {
        "title": "Batman Begins",
        "actors": [
          {
            "name": "Christian Bale"
          },
          {
            "name": "Michael Caine"
          },
          {
            "name": "Gary Oldman"
          }
        ]
      },
      {
        "title": "The Dark Knight Rises",
        "actors": [
          {
            "name": "Tom Hardy"
          },
          {
            "name": "Joseph Gordon-Levitt"
          },
          {
            "name": "Marion Cotillard"
          }
        ]
      }
    ]
  }
}
```

* We introduced the integer variable `firstActors` by declaring it as `$firstActors: Int`
* It can be access using `$firstActors` in the query itself

## Flexible Mutations With Input Object Variables

You can declare GraphQL variables for scalars, enums, or input object types. You can always refer to the documentation in the playground to find out what type you need to declare.

Let's create a new movie using the `createMovie` mutation. GraphQL variables are very useful in combination with [nested mutations](!alias-ubohch8quo), this is how we can use them together:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
mutation createMoonlight {
  createMovie(
    releaseDate: "2016-11-18"
    title: "Moonlight"
    actors: [{
      name: "Mahershala Ali"
    }, {
      name: "Shariff Earp"
    }]
  ) {
    title
  }
}
---
{
  "data": {
    "createMovie": {
      "title": "Moonlight"
    }
  }
}
```

Now, let's replace the constant values with variables. First, we can find out the types of the mutation arguments in the docs:

![](./create-movie-types.png?width=343)

We'll use these variables:

* `$releaseDate: DateTime!`
* `$title: String!`
* `$actors: [MovieactorsActor!]`

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
mutation createMoonlight($releaseDate: DateTime!, $title: String!, $actors: [MovieactorsActor!]) {
  createMovie(
    releaseDate: $releaseDate
    title: $title
    actors: $actors
  ) {
    title
  }
}
---
{
  "releaseDate": "2016-11-18",
  "title": "Moonlight",
  "actors": [{
    "name": "Mahershala Ali"
  }, {
    "name": "Shariff Earp"
  }]
}
---
{
  "data": {
    "createMovie": {
      "title": "Moonlight"
    }
  }
}
```

## Using GraphQL Variales for String Escaping

GraphQL variables are great to save cumbersome String interpolaton and escaping. In the Playground, we actually need to escape the double quotes in the movie title:

```graphql
mutation createMovie($releaseDate: DateTime!, $title: String!) {
  createMovie(
    releaseDate: $releaseDate
    title: $title
  ) {
    id
  }
}
---
{
  "title": "The \"Real" Question",
  "releaseDate": "2017-06-13"
}
```

However, using a GraphQL client (and not the Playground), we can save this additional escaping step. For example, with [`graphql-request`](), we can run

```js
const query = `mutation createMovie($releaseDate: DateTime!, $title: String!) {
  createMovie(
    releaseDate: $releaseDate
    title: $title
  ) {
    releaseDate
  }
}`

const variables = {
  title: 'The "Real" Question'
}

request('https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr', query, variables).then(data => console.log(data))
```

GraphQL variables are versatile and flexible, making them a useful tool when writing GraphQL queries.
