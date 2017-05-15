---
alias: chi6oozus1
path: /docs/tutorials/graphql-vs-firebase
layout: TUTORIAL
description: Learn about the differencs of Firebase and GraphQL
tags:
  - firebase
---

# GraphQL vs Firebase

With the variety of server-side technologies today, developers have a lot of choices when it comes to deciding what kind of backend to use for the next app. In this article, we want to explore the differences between Firebase and GraphQL, two very popular server-side technologies.

## Overview

Before diving into technical details, let's create some perspective on the two technologies and where they're coming from.

[Firebase](https://firebase.google.com/) was started as a Backend-as-a-Service with *realtime functionality* as its major focus. After it was acquired by Google in 2014, it evolved into a multifunctional mobile and web platform also integrating services like analytics, hosting and crash reporting.

[GraphQL](http://graphql.org/) is an open standard that defines how a server exposes data. It that was open-sourced by Facebook in 2015, but had been in internal use for much longer. Facebook released GraphQL as a *specification*, meaning that developers who want to use GraphQL either have to build a GraphQL server themselves or take advantage of services like [Graphcool](http://graph.cool/) that deliver a GraphQL API out-of-the-box.

In that sense, GraphQL and Firebase are already very different. Where GraphQL only specifies a way how clients can consume an API, but it's irrelevant where and how that API is provided, Firebase is a solution that ties any client closely to its platform.

## Structuring Data

### low maintainability and high cost for changes in firebase

With Firebase, data is stored in a *schemaless* manner using plain JSON. The database is organized as a large [JSON tree](https://firebase.google.com/docs/database/web/structure-data) where developers can update the existing data in any way they like. That means they can add, update and remove data entries by simply manipulating the tree without any default validation from Firebase.

This approach is very simple to understand but makes it more difficult to maintain a codebase on a longer term. Developers have to manually keep track of their data structures and need to make sure these are used consistently throughout the lifetime of the project. While this approach might work for smaller projects, it's practically impossible to build a sustainable and complex application with it.

The Firebase documentation further states that "building a properly structured database requires quite a bit of forethought". When designing the structure of the data, it is recommended to follow [best practices](https://firebase.google.com/docs/database/web/structure-data#best_practices_for_data_structure) and trying to keep the data tree as flat as possible to avoid *performance traps*. Since the full requirements for an application are rarely known upfront, it's extremely difficult to design a proper database structure before going into development. This becomes problematic when changes need to be made later on since these incur high costs due to the unstructured nature of the data stored in Firebase.

With the Firebase approach, developers also often end-up with structures that are *unnatural* to the way how we actually *think *about data. For example, when taking into account the Firebase [permission system](https://medium.com/@ChrisEsplin/firebase-security-rules-88d94606ce4a), you'll often end up with branches in the JSON tree whose names also encode data access rules like `admin`, `userReadable` or `userWritable`  which at that moment is adding unnecessary complexity to the nature of the data to be stored.

!!!

### flexibility & Safety with the Graphql type system

GraphQL on the other hand is based on a strong [type system](http://graphql.org/learn/schema/#type-system) that serves to describe the data that is going to be stored in a database. The data model (or *[schema](https://www.graph.cool/docs/reference/platform/data-schema-ahwoh2fohj/)*) for an application is expressed using a simple and powerful syntax, called GraphQL [Interface Definition Language](https://www.graph.cool/docs/faq/graphql-idl-schema-definition-language-kr84dktnp0/) (IDL). The types that are specified in the schema are the basis for the capabilities of the API.

 A simple example of a schema for a Twitter application written in the IDL could look as follows:

```
`type User {
  id: ID!
  username: String!
  followers: [User] @relation(name: "`Following`")
  follows: [User] @relation(name: "Following")
  tweets: [Tweet] @relation(name: "`UserTweets`")
}

type Tweet {
  id: ID!
  text: String!
  author: User @relation(name: "UserTweets")
}`
```

Strong type systems have a number of advantages. First and foremost, they provide the ability to update and extend the data model in a safe way during any stage of the development process. That's because types can be checked and validated at compile- and build-time. With this approach, many common errors that relate to the shape of the data flowing through an app are caught. In that sense, a strongly typed application brings together the best of both worlds when it comes to* flexibility *and* safety*!

A strong type system further provides lots of opportunities for [static analysis](https://en.wikipedia.org/wiki/Static_program_analysis) that go beyond data validation. With GraphQL for example, [static analysis of the queries to be sent](https://dev-blog.apollodata.com/5-benefits-of-static-graphql-queries-b7fa90b0b69a) can bring immense performance benefits.

The strongly typed nature of GraphQL ties in particularly well with other strongly typed languages, such as Flow, Typescript, Swift or Java. When building GraphQL applications with these languages, the schema can be understood as a *contract* between the client and the server. This enables great features like code generation or opportunities for mocking data on the client and server-side.

## Reading Data

### limited options for retrieving data with firebase

The most common way of reading data in Firebase is by using the [Firebase SDK](https://firebase.google.com/docs/reference/). No matter which platform you're using, you usually have to perform the following steps to retrieve data from the Firebase DB:

1. Get a local *instance of the Firebase DB* (which stores the JSON tree that was mentioned above). In the Javascript SDK, you'd obtain the instance with this call: `const db = firebase.database()`
2. Specify the *path* where in the tree you want to read data from, e.g.: `const tweets = db.ref('user/tweets')`
3. Provide a *callback* where you specify what should happen to the data once it's received. Here you can use either `on` which will execute the callback every time data changes or `once` if you're only interested in that data at one particular point in time, e.g. `tweets.once('value', snapshot => { console.log(snapshot.val()) })`

This approach makes it easy to retrieve simple data points from the database. However, accessing more complex data that's potentially nested under different branches in the JSON tree (which is a very common scenario in the majority of applications) becomes very cumbersome and is likely to have a poor performance.

Other common requirements of many applications like pagination or search don't have any out-of-the box support with Firebase and require lots of extra work. Firebase has no server-side capabilities for filtering data based on certain properties of the objects to be retrieved (e.g. only retrieve users with an `age` higher than 21). Meaning a client can not specify such filter conditions when calling `on` or `once`. Instead the filtering has to be performed by the client itself which can become problematic especially for lower-end devices.

Note that Firebase also exposes a [REST API](https://firebase.google.com/docs/database/rest/start) where the different endpoints correspond to the paths in the JSON tree. However, due to the unstructured nature of the data being stored, this API provides few guarantees about the data it delivers and thus should only be used in exceptional cases.

### powerful and complex query capabilities with graphql

GraphQL uses the concept of [queries](http://graphql.org/learn/queries/) for reading data from the database. A *query* is a simple and intuitive description of the client's data requirements. The query gets sent over to the GraphQL server where it is resolved and the resulting data is returned as a JSON object.

Let's consider a simple example based on the schema that we saw above:

```
`query {
  allTweets {
    ``text
    author {
      username
    }``
  }
}`
```

This query asks for all the tweets that are currently stored in the database. The server response will include all the pieces of information that are specified in the *payload* of the query. Here that's the tweets' `text `as well as the `username` of the `author`. A response could potentially look as follows:

```
{
  "data": {
    "allTweets": [
      {
        "text": "GraphQL is awesome 🚀",
        "author": {
          "username": "johnny"
        }
      },
      {
        "text": "Firebase? Sounds dangerous!🔥😱",
        "author": {
          "username": "mike"
        }
      },
      ...
    ]
  }
}
```

Another way of looking at a GraphQL query is as a *selection of JSON fields*. The query has the same *shape* as the JSON response, so it can be seen as a JSON object that has *only* *keys* but* no values*.

This simple query already gives an idea about the power of GraphQL queries when it comes to retrieving *nested* information. In the above example above, we're only going one level deep by following the relation from `User` to `Tweet` (via the `author` field). However, we could extend the query and also ask for the last three followers of each `author`:

```
`query {
  allTweets {
    ``text
    author {
      username
      followers(last: 3) {
        username
      }
    }``
  }
}`
```

Having the ability to query nested structures by simply following the edges of the data graph is an immensely powerful feature that makes for much of the power and expressiveness of GraphQL!

Next to `last` a GraphQL API typically accepts a few more related arguments such as `first`, `before`, `after` and `skip` that can be passed when querying a *to-many-relation. *This capability of an API makes it very easy to implement pagination on the client by asking for a specific range of objects from the list.

With the flexibility of the GraphQL spec, it's further possible to specify powerful filters on the client that will be resolved by the server. In the [Graphcool Simple API](https://www.graph.cool/docs/reference/simple-api/overview-heshoov3ai/), it's also possible to specify a filter to restrict the amount of information that's returned by the server. Let's consider two simple examples.

This query retrieves all tweets where the `text` contains the string "GraphQL":

```
query {
  allTweets(filter: {
    text_contains: "GraphQL"
  }) {
    text
    author {
      username
    }
  }
}
```

Another query could retrieve all tweets that have been sent *after* December 24, 2016:

```
{
  allTweets(filter: {
    createdAt_gt: "2017-12-24T00:00:00.000Z"
  }) {
    text
    author {
      username
    }
  }
}
```

It's further possible to combine filter conditions arbitrarily using the `AND` and `OR` operators.

## Updating Data

### writing directly To the Firebase json tree

The most common scenario to make changes to the database in Firebase is again by using the given SDK (though the REST API also offers this functionality). The SDK exposes [four different methods](https://firebase.google.com/docs/database/admin/save-data) for saving data to the database: `set`, `update`, `push` and `transaction`. Each of these is to be used in a specific context, e.g. `push` is used to append new items to a list, `set` and `update` can both be used to update an existing data entry (note that the difference between them is [very subtle](http://stackoverflow.com/questions/38923644/firebase-update-vs-set)). Deleting data can be done by calling `remove` (or with `set` / `update` and then passing `null` as an argument).

Similar to when reading data from the JSON tree, with all of these methods a *path *needs to be specified that defines where in the JSON tree the write operation should be performed.

Creating a tweet using Firebase could look somewhat similar to this:

```
`const tweet = { ... }
const newTweetKey = firebase.database().ref('user/tweets').push()
const updates = { }
updates['user/tweets/' + `newTweetKey`] = `tweet
firebase.database().ref().update(updates)``
```

With this approach, Firebase suffers from the same limitations that we've already noted with querying data. Most notably there isn't a good way of performing more complex writes to the database in most scenarios, which means again that a lot of work will have to be done on the client-side to compensate for the lack of server-side capabilities.

### updating and saving data with graphql mutations

In GraphQL, changes to the backend are done using so-called [mutations](http://graphql.org/learn/queries/#mutations). Mutations syntactically follow the structure of queries, but they're also causing *writes* to the database rather than only reading from it. A mutation for creating a new tweet in our known data model could look like this:

```
`mutation {
  createTweet(text: "GraphQL is awesome!", authorId: "abcdefghijklmnopq") {
    id
  }
}`
```

This mutation creates a new tweet, associating it with the user that is identified by the ID `abcdefghijklmnopq` while also returning the `id` of the new tweet. Mutations, just like queries, allow to specify a *payload* that should be returned by the server after the mutation was performed. This allows for easily accessing the new data without additional server roundtrips!

Another handy side-effect of performing mutations in the GraphQL way is the ability for *[nested mutations](https://blog.graph.cool/improving-dx-with-nested-mutations-af7711113d6)*, i.e. creating multiple related nodes at once. We could for example create a new `User` along with a first `Tweet` - both in the same mutation:

```
`mutation {
  createUser(username: "lee", tweets: [{ text: "This is my first Tweet 😎" }]) {
    id
    tweets {
      id
    }
  }
}`
```

## Realtime Functionality

### realtime connection to the firebase db

The initial product of Firebase was a *realtime database* which eventually evolved into the more broad backend solution that it is today. Because of these roots however, realtime functionality is baked deep into Firebase's core. This also means that the API design of the Firebase SDK was focussed on realtime functionality from the very beginning, which is why many other common feature sometimes feel a bit unnatural or less intuitive to work with.

 The realtime functionality in Firebase can be used by subscribing to specific data in the JSON tree with a callback and getting notified whenever it changes. Taking again the Javascript SDK as an example, we'd use the `on` method on the local DB reference and then pass a callback that gets executed on every change:

```
`var ``tweets`` = firebase.database().ref('user/tweets')
`tweets.on('value', snapshot => { console.log(snapshot.val()) }``
```

### Sophisticated realtime updates with graphql subscriptions

Realtime functionality in GraphQL can be implemented using the concept of [*subscriptions*](http://graphql.org/blog/subscriptions-in-graphql-and-relay/). Subscriptions are syntactically similar to queries and mutations, thus again allowing the developer to specify their data requirements in a declarative fashion.

A subscription is always coupled to a specific type of *event *that is happening in the backend. If a client subscribes to that event type, it will be notified whenever this even occurs. We can imagine three obvious events per type:

* *creating* a new node of a specific type (e.g. a user creates a new `Tweet`)
* *updating *an existing node of a specific type (e.g. a user changes the text of an existing `Tweet`)
* *deleting* an existing node of a specific type (e.g. a user deletes a `Tweet`)

Whenever one of these mutations now happens, the subscription will *fire* and the subscribed client receives the updated data.

A simple subscription to be notified for all of these events on the `Tweet` type (i.e. when a new tweet is created, or an existing one was updated or deleted) could look as follows:

```
`subscription {
  Tweet {
    mutation # is either CREATED, UPDATED or DELETED
    node {
      id
      text
    }
  }
}`
```

There a two things to note about how the payload of this subscription is specified:

* the `mutation` field carries information about the kind of mutation that was performed (`CREATED`, `UPDATED` or `DELETED`)
* the `node` field allows to access information about the new (or updated) tweet

By using a `filter`, it's possible to directly specify which kind of mutation we're interested in. In this subscription, we only want to get informed about tweets that were *updated*:

```
`subscription {
  Tweet(filter: {
    mutation_in: [UPDATED]
  }) {
    node {
      text
    }
    previousValues {
      text
    }
  }
}`
```

By including `previousValues` in the payload, we're able to not only retrieve the new value for the tweet's `text` (which is nested under `node`) but also the value of `text` before the change (this also works for `DELETE` mutations).

If you want to know more about how subscriptions work in GraphQL and how they can be used in a *React* application, you can check out [this tutorial](https://www.graph.cool/docs/tutorials/worldchat-subscriptions-example-ui0eizishe/).

## Authorization

### Restricted & Error-prone permissions with JSON-based Rules in firebase

Firebase uses a rule-based permission system where the data access rules are specified in a JSON object. The structure of that JSON object needs to be identical to the one of the tree that represents the database.

A simple version of such a JSON file could look as follows. Here *read *permissions are only granted if a tweet was created in the last 10 minutes and *write* access is granted to everyone:

```
{
  "rules": {
    "tweets": {
      // only messages from the last ten minutes can be read
      ".read": "data.child('timestamp').val() > (now - 600000)",
      // everyone is allowed to perform writes (create, update, delete)
      ".write": true
    }
  }
}
```

In general, it's possible two specify rules for *reading *and *writing* data. However, it is not possible to distinguish out-of-the-box between different types of *writes*, such as *creating*, *updating* or *deleting* data.

As an example, this restriction means that you can not express in a simple manner that only a specific audience should be able to create new tweets and a different audience should be able to create *and* delete tweets. It's generally still possible to write such permissions but they require getting into the weeds of the Firebase permission system and writing complex and long permission strings.

Another restriction of the Firebase permission system is that permission rules can only be applied to *entire* *objects *in the DB. Consider an example where a `User` object might have properties for `name`, `age` and `relationshipStatus`. This is all stored in the same JSON branch. With this structure, it is not possible to declare a permission that would expose only the `name` and `age` of each user to everyone and have only the  `relationshipStatus` be visible to a more fine-grained audience such as the user's friends.

A major drawback of the Firebase permission system is that rules are plain strings that are written into the mentioned JSON object. This approach is extremely error-prone and doesn't allows the developer to take advantage of tooling to ensure the rules are written correctly. The only feedback developers get on the correctness of their permissions is when “deploying” the rules which makes for a suboptimal developer workflow.

### expressive permissions based on graphql queries

Being only a *specification* of how an API should expose its data, there is no default solution for how permissions should be handled in GraphQL. This means that the way how authentication and authorization are handled in GraphQL really depends on the concrete server-side implementation. The following section will therefore describe [how Graphcool implements permissions](https://www.graph.cool/blog/2017-04-25-graphql-permission-queries-oolooch8oh/) with an approach that leverages the power of a well-known and basic concept: GraphQL Queries.

Similar to Firebase, Graphcool follows a *whitelist* approach in the permission system. This means that all operations have to be explicitly allowed (i.e. *whitelisted*) so that they can be performed at all - if no permissions are specified, no operation is possible. However, in contrast to Firebase, it's possible to specify permissions based on the actual operation that is to be performed, including: Reading, writing, updating and deleting data of a specific type.

With every permission, it is possible to specify exactly to which fields it should apply. This solves the above issue with a user's `relationshipStatus` that should only be visible to the user's friends in a trivial way since it's possible to simply include these fields in the permission!

There are generally three ways of specifying the audience for a permission:

* Make the operation available to *everyone*
* Make the operation available only to *authenticated* users
* Use a *[permission query](!alaias-iox3aqu0ee/)* for very fine-grained control about the access rights

The first two audiences are easy to set by ticking simply a checkbox in the Graphcool console. The third option, writing a *permission query*, allows to express any permission requirement using the syntax of GraphQL queries. Developers don't have to learn a new way of configuring permissions, instead they can express everything with a syntax they're already familiar with!

A sample permission query that only allows the author of a tweet to delete it could look as follows:

```
query ($user_id: ID!, $node_id: ID!) {
  SomeTweetExists(
    filter: {
      id: $node_id,
      author: {
        id: $user_id
      }
    }
  )
}
```


Permission queries generally work in the way that they're evaluated right before the requested operation happens on the server-side. Only if the permission query returns `true`, the operation will actually be performed.

## Client-Side Technologies

A major part of the value of any server-side technology is the ease of using it on the client. As already mentioned, Firebase's recommended way of interacting with their backend is by using their custom SDKs. The REST API can be used as well but is more cumbersome to work with due to the unstructured nature of the JSON database that results in a certain unpredictability when accessing it through REST.

Firebase provides SDKs for all major development platforms such as Android, iOS and the Web. For the latter, there are also specific bindings for UI frameworks like React or Angular. When deciding to use Firebase for their next project, developers make themselves completely dependent on the infrastructure that is provided by Google. If Google takes down Firebase, the application's whole data layer will have to be rewritten!

GraphQL on the other hand can be consumed using plain HTTP (or any other transport layer). However, usage of client-side frameworks that implement common functionality can help save a lot of time and gives developers a head-start when working with GraphQL. There are two major client libraries at the moment:


* [Apollo](http://dev.apollodata.com/): A fully-featured and flexible GraphQL client. It offers handy features such as caching, optimistic UI, pagination, helpers for server-side rendering and prefetching of data. ~~Apollo also is the only GraphQL client right now that has out-of-the-box support for [subscriptions](https://dev-blog.apollodata.com/graphql-subscriptions-in-apollo-client-9a2457f015fb)~~. It also integrates with all major UI frameworks such as React, Angular or Vue and is also available on iOS and Android.
* [Relay](https://facebook.github.io/relay/): Facebook's GraphQL client that was open-sourced alongside GraphQL and recently upgraded to its official 1.0 release: [Relay Modern](https://facebook.github.io/relay/docs/relay-modern.html). Relay is a very sophisticated GraphQL client that however comes with a notable learning curve. It's not as easy to get started with as is the case for Apollo. It's however highly optimized for performance and especially shines in the context of complex and large-scale applications with lots of data-interdependencies.

For a deep-down comparison of Relay and Apollo, you can check out [this article](!alias-iechu0shia/) as well as the [Learn Apollo](http://www.learnapollo.com/) and [Learn Relay](https://www.learnrelay.org/) guides for comprehensive tutorials.

## Standards & Community

There are no standards that Google adheres to with the Firebase platform. Development is closed-source and the community for getting help with Firebase is rather scarce (not considering a few Firebase evangelists that seem to produce the entire content around Firebase on the web).

GraphQL however is being developed [in the open](https://github.com/graphql). Everybody is invited to join and contribute to the discussion about how to evolve GraphQL in the future. Despite its young age, an incredible community has already grown around it. Many major companies are moving their APIs towards GraphQL. Facebook of course being the primary example, but also companies like [GitHub](https://developer.github.com/early-access/graphql/), [Yelp](https://engineeringblog.yelp.com/2017/05/introducing-yelps-local-graph.html), [Shopify](http://www.graphql.com/articles/graphql-at-shopify) or [Coursera](https://building.coursera.org/blog/2016/10/28/graphql-summit/) have hopped on the train and take advantage of all the great GraphQL features!

With [GraphQL Europe](https://graphql-europe.org/) and [GraphQL Summit](http://www.graphql.com/summit/) there are two major conferences happening in Berlin and San Francisco that gather the GraphQL communities.

## Getting Started with Graphcool

The fastest way to get your hands dirty and try out GraphQL yourself is by using the [Graphcool CLI](https://www.npmjs.com/package/graphcool). Let's use the sample data model from above to create a fully-fledged GraphQL backend:

```
# Install the Graphcool CLI
npm install -g graphcool

# Create the GraphQL API based on a remote schema
graphcool init --schema http://graphqlbin.com/twitter.graphql
```

This will create a GraphQL API that you can access using the displayed endpoints. If you want to explore the capabilities of the API, simply paste the URL into a browser and start sending queries and mutations.
[Image: https://quip.com/-/blob/KJaAAA6Bhbj/VlHZwt433FttfaoqpnQbxg]Also be sure to checkout the following resources that will help you get started and learn about GraphQL:

* [Quickstart examples](https://graph.cool/docs/quickstart/) demonstrating how to setup a full-stack app with a client technology of your choice
* [Full-stack tutorial series](http://graph.cool/freecom) to build a clone of the Intercom support chat
* [Graphcool](https://www.graph.cool/blog/) and [Apollo](https://dev-blog.apollodata.com/) blogs with lots of helpful tutorials and insightful articles around GraphQL
* [GraphQL Weekly](https://graphqlweekly.com/), a newsletter about the latest ongoings in the GraphQL community

## Summary

Firebase enforces an artificial way of thinking about data to make sure there are no performance penalties and permissions work properly.
