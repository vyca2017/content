---
alias: gahth9quoo
path: /docs/faq/the-mutation-payload-in-graphql
layout: FAQ
description: Mutations can be used to execute different data changes. The mutation payload in GraphQL is the data that is returned as a result of the mutation.
tags:
  - graphql
  - mutations
related:
  further:
    - ol0yuoz6go
    - koht6ethe3
  more:
    - ook6luephu
---

# The Mutation Payload In GraphQL

Mutations can be used to execute different data changes, like *creating or updating a node*. Additionally, you receive data back from the mutation, which is referred to as the **mutation payload**.

The mutation payload can be seen as a confirmation to the client that the mutation has been run successfully. Sometimes, we don't need any of the available information in the mutation payload, but specifying at least a single field as **including the mutation payload is mandatory**.

## Defining The Information Returned From A Mutation

When running a mutation, we can select the fields that should be included as part of the mutation response. Commonly when creating a new node, we're interested in its `id`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
mutation {
  createMovie(
    releaseDate: "2016-11-18"
    title: "Moonlight"
  ) {
    id
  }
}
---
{
  "data": {
    "createMovie": {
      "id": "cj040x2ih98jw01438hgvpx0l"
    }
  }
}
```

Another common use case is including a field in the mutation payload that has just been updated using an update mutation. This is especially needed when using clients that use an internal cache for consistent data in the UI, such as Apollo Client or Relay:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
mutation {
  updateMovie(
    id: "cj040x2ih98jw01438hgvpx0l"
    title: "Another Moonlight"
  ) {
    title
  }
}
---
{
  "data": {
    "createMovie": {
      "title": "Another Moonlight"
    }
  }
}
```

## Exploring The Shape Of A Mutation Payload

Both the autocompletion and the automatically generated docs in the GraphiQL playground help with exploring the mutation payload. First, find the mutation in the list of mutations (`createMovie` in this case):

![](./mutations.png?width=335)

By clicking on the return type (`Movie` in this case) you can see the available fields for the payload of that mutation:

![](./movie-payload.png?width=335).

You can read more about [tips and tricks when using the GraphQL Playground](!alias-ook6luephu).
