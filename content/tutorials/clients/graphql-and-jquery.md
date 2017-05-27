---
alias: kohj2aengo
path: /docs/tutorials/graphql-and-jquery
layout: TUTORIAL
preview: jquery.png
description: Learn how to use GraphQL with jQuery by building a simple Pokedex example app
tags:
  - queries
  - mutations
  - jquery
  - open-source
related:
  further:
    - koo4eevun4
  more:
---


# How to use GraphQL with jQuery

Despite the growing number of modern web frameworks and Javascript libraries such as React & Angular, there is still a big community of developers using plain Javascript and [jQuery](https://jquery.com/) to build web applications.

In this post, we are going to to give a quick example demonstrating how to interact with a GraphQL backend using `$.post` (`$.ajax` works as well).


## What is GraphQL?

[GraphQL](https://www.graphql.org) is an open-source technology that was released by Facebook in 2015. Briefly stated, it is a specification for an _API Design Paradigm_ that determines _how_ a client can request data from a server.

## GraphQL vs REST

If you have worked with Web APIs before, you might have come across the term _REST_. A REST API defines a set of _endpoints_ that a client can use to request data. In the following, we'll do a quick comparison between the basic interactions of a REST and a
 GraphQL API. For a more detailled comparisons, take a look these two blog posts:

- [REST API downfalls, and dawn of GraphQL](https://medium.com/@ottovw/rest-api-downfalls-and-dawn-of-graphql-dd00991a0eb8#.dmpuurhl0)
- [GraphQL in the age of REST APIs](https://medium.com/chute-engineering/graphql-in-the-age-of-rest-apis-b10f2bf09bba#.l32a7mb88)

Consider this example of an application with users that can follow each other. In that scenario, we might have the following two endpoints in a REST API:

```
GET
/user

GET
/user/<id>/followers
```

The first endpoint, `user`, returns a list of all users (containing each user's `name` and `id`) in the server's database. The second endpoint can be used to request all the followers of a specific user by providing the user's `id`.

In GraphQL, there is only one API endpoint and all request that are sent to the server have to be POST requests! That is because the _body_ of the POST request will carry the actual `GraphQL` query that the server will resolve and fetch from the database.

In GraphQL, we thus wouldn't send our requests to two different endpoints if we wanted to recreate the same functionality as our examplary REST API. Instead, we'd send POST requests with different GraphQL queries to the single API endpoint:

```
POST
Body:
# get names and ids of all users
{
  allUsers {
    id
    name
  }
}

POST
Body:
# get ids and names of all followers of user with id <id>
{
  User(id: "<id>") {
    followers {
      id
      name
    }
  }
}
```

## Creating your own GraphQL API

Since GraphQL is only a _specification_, an actual GraphQL server can be implemented with any server-side technology. However, implementing your own GraphQL server is not a trivial task!

With [Graphcool](https://graph.cool) you can set up your GraphQL API and get started in only a few minutes. All you need to do is defining the _data model_ of your application and you're good to go.

In the following we're going to use a simple Pokedex application as an example where a user can view a list of Pokemons and add new Pokemons to the list.

The [schema](!alias-ahwoh2fohj/) for our example simply consists of a `Pokemon` type, in GraphQL, we can specify that as follows:

```graphql
type Pokemon {
  name: String
}
```

In order to create a Graphcool project for the Pokedex application, you can simply download the schema file from [here](https://github.com/graphcool-examples/pokedex-jquery/blob/master/Pokedex.schema) and then run the following command in the terminal:

```
graphcool init Pokedex.schema
```

This will create a new project called `Pokedex` in the [Graphcool console](https://console.graph.cool) along with one type called `Pokemon`.


## Fetching the List of Pokemons

As mentioned before, every request that we send to the GraphQL API has to be a POST request. We can therefore use the [`jQuery.post()`](https://api.jquery.com/jquery.post/) method, sending the actual GraphQL query as the _body_ of the request by setting the `data` argument of the `jQuery.post()` function. In code, this looks as follows:

```js
$.post({
  url: 'https://api.graph.cool/simple/v1/__PROJECT_ID__',
  data: JSON.stringify({ "query": " { allPokemons { id name } } " }),
  contentType: 'application/json'
}).done(function(response) {
  console.log('Fetched Pokemons:', response.data.allPokemons);
});
```

Notice that there is that the actual GraphQL query needs to passed as the value in a JSON object with the key `query`, so the plain query looks as follows:

```graphql
{
  allPokemons {
    id
    name
  }
}
```

In order to send it using `jQuery.post()`, we reduced it to one line, set it as the value for a property `query` in a JSON object and then used `JSON.stringify()` to serialize this JSON object into a string that we can send as the body of our request.


## Creating a new Pokemon

We can also create new Pokemons in the database. In GraphQL, every operation that changes data in the database is called a _mutation_.

We can create a new Pokemon using jQuery like so:

```js
$.post({
  url: 'https://api.graph.cool/simple/v1/__PROJECT_ID__',
  data: JSON.stringify({ "query": "mutation { createPokemon(name: \"Pikachu\") { id name } } " }),
  contentType: 'application/json'
}).done(function(response) {
  console.log('Created new Pokemon:', response.data.createPokemon);
});
```

Notice two important things about this request:

1. Despite the fact that we are sending a mutation, not a query, the key for the GraphQL mutation in the stringified JSON object still needs to be `query`.
2. In the GraphQL mutation, we need to use the keyword `mutation`

Let's take a look at the raw GraphQL mutation written in multiple lines for better readability:

```graphl
mutation {
  createPokemon(name: "Pikachu") {
    id
    name
  }
}
```

If you want to see how you can use these mutations in an example project, you can check out our [example project](https://github.com/graphcool-examples/pokedex-jquery).
