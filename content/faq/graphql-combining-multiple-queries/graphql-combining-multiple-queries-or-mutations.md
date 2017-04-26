---
alias: cahzai2eur
path: /docs/faq/graphql-combining-multiple-queries-and-mutations
layout: FAQ
preview: graphql-multiple-queries.png
title: Combining multiple GraphQL queries or mutations in one request
shorttitle: Combining multiple GraphQL queries or mutations
description: In GraphQL you can run multiple queries or mutations in one request using GraphQL aliases.
tags:
  - mutations
  - queries
  - graphql
related:
  further:
    - nia9nushae
    - koo4eevun4
    - ol0yuoz6go
  more:
  - taith2va1l
  - ga2ahnee2a
  - ligh7fmn38
  - uu2xighaef
---

# Combining multiple GraphQL queries or mutations in one request

We can combine multiple GraphQL queries or multiple GraphQL mutations in one HTTP request. Let's find out how that works exactly!

## Executing multiple GraphQL queries

Imagine we are building a GraphQL backend that provides information on pokemons. To query a specific pokemon we can use the `Pokemon(name: String!)` query like this:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixt466kr04r701381x3n9d3a
disabled: false
---
query {
  Pokemon(name: "Pikachu") {
    id
    type
  }
}
---
{
  "data": {
    "Pokemon": {
      "id": "cixt4896j1yi40110qeq30qug",
      "type": "ELECTRIC"
    }
  }
}
```

To query multiple individual Pokemons at once, we simply include the `Pokemon` query multiple times and add an additional query alias per query:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixt466kr04r701381x3n9d3a
disabled: false
---
query {
  mew: Pokemon(name: "Mew") {
    id
    type
  }

  meowth: Pokemon(name: "Meowth") {
    id
    type
  }
}
---
{
  "data": {
    "mew": {
      "id": "cixt49ax61zfu01107zfuaxii",
      "type": "PSYCHIC"
    },
    "meowth": {
      "id": "cixt4978x1u0r01161bp7nffw",
      "type": "NORMAL"
    }
  }
}
```

It's useful to remember that *multiple queries in one request are executed in parallel*.

## Executing multiple mutations

Let's create some more Pokemons! We use the `createPokemon(name: String!, type: Enum!)` mutation like that:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixt466kr04r701381x3n9d3a
disabled: true
---
mutation {
  createPokemon(name: "Onyx", type: ROCK) {
    type
  }
}
---
{
  "data": {
    "createPokemon": {
      "type": "ROCK"
    }
  }
}
```

If we want to add a lot of new Pokemons, doing one request per mutation might become an annoying overhead. Instead, we can execute multiple mutations in one request similar to queries:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixt466kr04r701381x3n9d3a
disabled: true
---
mutation {
  charmander: createPokemon(name: "Charmander", type: FIRE) {
    type
  }

  bulbasaur: createPokemon(name: "Bulbasaur", type: GRASS) {
    type
  }
}
---
{
  "data": {
    "charmander": {
      "type": "FIRE"
    },
    "bulbasaur": {
      "type": "GRASS"
    }
  }
}
```

However, unlike queries, *multiple mutations are executed sequentially*. That means that a mutation is only executed after the previous mutation has finished execution. The execution order is the same as the order in the query itself, from top to bottom.


# Resources

You can use this mechanism to batch queries, such as with the [batchql library](https://github.com/matthiasak/batchql) that wraps GraphQL queries with ES6 promises. It batches queries that are sent from different parts of the application and makes sure that the responses are mapped correctly to the different queries. Apollo Client uses [a similar mechanism](!alias-ligh7fmn38).
