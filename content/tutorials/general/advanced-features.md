---
alias: eath7duf7d
path: /docs/tutorials/advanced-features
preview: advanced-features.png
layout: TUTORIAL
description: Learn about advanced capabilities of the Graphcool API
tags:
  - subscriptions
  - mutations
  - queries
  - filter
  - pagination
  - schema
more:
  - heshoov3ai
  - ol0yuoz6go
  - nia9nushae
  - aip7oojeiv
further:
  - e8a6ajt8ax
  - ui0eizishe
  - aing7uech3
---

# Advanced GraphQL Features of the Graphcool API

GraphQL allows for much more advanced communication between a client and a server than possible with any other API standard.

In this post, we'll highlight a few of the advanced GraphQL features that you get out of the box when using Graphcool. We'll use the following data model as the basis for all the following examples:

```graphql
type User {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  username: String!
  followers: [User!]! @relation(name: "Following")
  follows: [User!]! @relation(name: "Following")
  tweets: [Tweet!]! @relation(name: "UserTweets")
}

type Tweet {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  text: String!
  author: User @relation(name: "UserTweets")
}
```


## Complex Queries

First and foremost, clients have the ability to send [complex](!alias-nia9nushae) queries that represent their data requirements to a server. The server will respond with precisely that information which enables a rapid product development cycle.

### Nesting

A major advantage of GraphQL is that clients can request data that goes over multiple relationships. With the above data model, it would be possible to ask for  specific `Tweet` (by specifying the tweets `id`), it's `author` and their `followers`. With the GraphQL [GraphQL SDL (schema definition language)](!alias-kr84dktnp0), this quite complex query could still be written in a natural way:

```graphql
{
  Tweet(id: "eath7dufeag5oelah") {
    text
    author {
      username
      followers {
        username
      }
    }
  }
}
```

Another example would be to ask for all users, for each including a list of who they follow and say the last three tweets of these people:

```graphql
{
  allUsers {
    username
    follows {
      username
      tweets(last: 3) {
        text
      }
    }
  }
}
```

### Filtering

The Graphcool API allows clients to specify [powerful filters](!alias-xookaexai0) that restrict precisely what information the server should return. Filter can be applied to all the fields of the types in the data model.

Here's an example for a query asking for all the tweets where the `text` contains the string _GraphQL_:

```graphql
query {
  allTweets(filter: {
    text_contains: "GraphQL"
  }) {
    text
  }
}
```

We could also ask for all tweets that have been sent _after_ December 24, 2016:

```graphql
{
  allTweets(filter: {
    createdAt_gt: "2016-12-24T00:00:00.000Z"
  }) {
    text
  }
}
```

Similar to queries, filters can also be expressed over multiple relationships. Here's a query that asks for all tweets that are written by a `User` whose `username` starts with the letter _A_:

```graphql
{
  allTweets(filter: {
    author: {
      username_starts_with: "A"
    }
  }) {
    text
  }
}
```

Note that it's also possible to combine filters using `AND` and `OR`. We could thus combine all previous queries into a single one:

```graphql
{
  allTweets(filter: {
    AND: [
      {
        author: {username_starts_with: "A"}
      },
      {
        createdAt_gt: "2016-12-24T00:00:00.000Z"
      },
      {
        author: {username_starts_with: "A"
      }
    }]
  }) {
    text
  }
}
```


### Pagination

When working with lists in an app, it's a common feature to only display a _chunk_ of that list (e.g. a page with 20 items) and let the user navigate these chunks.

With the Graphcool API, for each list in the data graph, it's possible to pass a number of [special modifiers](!alias-ojie8dohju/) that enable a variety of [client-side pagination approaches](https://dev-blog.apollodata.com/understanding-pagination-rest-graphql-and-relay-b10f835549e7).

The easiest modifiers are `first` and `last` that will precisely return the _first_ and _last_ items from a list, e.g. the _last_ ten users:

```graphql
query {
  allUsers(last: 10) {
    username
  }
}
```

Using `skip`, you can further disregard a number of items in a list. Let's assume a list with 100 users, where you wanted to return users in the range 50 to 60. You can achieve this by combining `skip` and `first`:

```graphql
query {
  allUsers(skip: 50, first: 10) {
    username
  }
}
```

If you're aware of a particular item in the list that you want to use as an anchor and request the items coming _before_ or _after_ it, you can use the `before` and `after` modifiers. Here's an example asking for all tweets coming after the tweet that has the id `eath7dufeag5oelah`:

```graphql
{
  allTweets(after: "eath7dufeag5oelah") {
    text
  }
}
```


## Nested Mutations

Another great convenient feature of the Graphcool API is the ability to send [_nested_ mutations](!alias-ubohch8quo/) that allow to create multiple _related_ nodes at once. We could thus create a new `User` along with their first `Tweet`:

```graphql
mutation {
  createUser(username: "lee", tweets: [{ text: "This is my first Tweet 😎" }]) {
    id
    tweets {
      id
    }
  }
}
```

Note that it's possible to specify a payload in a mutation that allows to retrieve the updated data from the backend in a single roundtrip!


## Realtime with Subscriptions

Realtime functionality becomes more and more crucial to many applications today. With GraphQL, these features can be implemented using so-called [subscriptions](!alias-aip7oojeiv).

Clients can specify that they want to get notified when certain data in the database changes. The GraphQL server will then take care of sending that information over. Note that in Graphcool, subscriptions are implemented using websockets.

There are generally three different kinds of _events_ a client be informed about:

- when a new node is _created_
- when an existing node is _updated_
- when an existing node is _deleted_

Subscriptions use the same GraphQL syntax as queries and mutations, so when writing a subscription it's possible to take advantage of all the complex querying features we saw in the first section.

Here's a simple example for a subscription that will fire every time a new `Tweet` is created, _or_ an existing one is updated or deleted:

```graphql
subscription {
  Tweet {
    mutation # contains CREATED, UPDATED or DELETED
    node {
      id
      text
    }
    previousValues {
      id
      text
    }
  }
}
```

The payload of a subscription contains some special fields that provide information about the event that happened.

The `mutation` field contains either of three values indicating which of the three above mentioned event types happened: `CREATED`, `UPDATE` or `DELETED`.

The `node` field represents the `node` that was _created_ or _updated_. `previousValues` can be used in the case _updated_ or _deleted_ nodes to find out what the values of that node were before they were updated in the database.
