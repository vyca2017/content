---
alias: 8uakjj68lp
path: /docs/tutorials/freecom-graphql-server
layout: TUTORIAL
preview: freecom-part-1.png
title: 'Requirements Analysis & Designing the Data Model'
description: Freecom is the free alternative to Intercom
tags:
  - freecom
related:
  further:
    - koo4eevun4
  more:
    - e8a6ajt8ax
---

# Requirements Analysis & Designing the Data Model




#### Complete Schema

The complete schema that we need in order to create the Graphcool backend looks as follows:

```graphql
type Customer {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  name: String!
  conversations: [Conversation!]! @relation(name: "ConversationsFromCustomer")
}

type Agent {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  slackUserId: String!
  slackUserName: String!
  messages: [Message!]! @relation(name: "MessagesFromAgents")
}

type Conversation {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  slackChannelName: String!
  customer: Customer @relation(name: "ConversationsFromCustomer")
  messages: [Message!]! @relation(name: "MessagesInConversation")
}

type Message {
  id: ID!
  createdAt: DateTime!
  updatedAt: DateTime!
  text: String!
  agent: Agent @relation(name: "MessagesFromAgents")
  conversation: Conversation @relation(name: "MessagesInConversation")
}
```

Notice that each of the types now also includes the Graphcool [system fields](!alias-uhieg2shio#id-field), `id`, `createdAt` and `updatedAt`.

Here is a graphical overview of the relations in our final schema:

![](http://i.imgur.com/bd5rQ2k.png)

- **one** `Agent` is related to **many** `Message`s
- **one** `Agent` is related to **many** `Conversation `s
- **one** `Customer` is related to **many** `Conversation`s
- **one** `Conversation ` is related to **many** `Message `s

## Preparing the GraphQL server

You can now either create these model types and relations manually in the Web UI of the  [Graphcool console](https://console.graph.cool) or use the [command-line interface](https://www.npmjs.com/package/graphcool) to create the project including the data model for you. Simply download the complete [schema file](https://github.com/graphcool-examples/schemas/blob/master/freecom.schema) and execute the following command in a Terminal:

```sh
graphcool create freecom.schema
```

Note that this will require you to authenticate with Graphcool by opening a browser window before creating the actual project.

Once the project was created, you can interact with it via two different endpoints:

- [`Simple API`](!alias-heshoov3ai): This endpoint creates an intuitive GraphQL API based on the provided data model and is optimized for usage with Apollo - _it's the one we'll be using in this tutorial!_
- [`Relay API`](!alias-aizoong9ah): This endpoint can be used in applications that use [Relay](https://facebook.github.io/relay/), a GraphQL client developed by Facebook and with some specific requirements for the GraphQL API

![](http://i.imgur.com/6yMWjrA.png)

We'll be using the endpoint for the `Simple API`! If you ever lose the endpoint, you can simply find it in the [Graphcool console](https://console.graph.cool) by selecting your project and clicking the _Endpoints_-button in the bottom-left corner.

![](http://imgur.com/kPF9uqs.png)

## Playgrounds

If you're keen on trying out your GraphQL API before we start writing actual code in the next chapter, you can explore the capabilities of the API in a [Playground](!alias-uh8shohxie), a browser-based and interactive environment for interacting with a GraphQL server.

To open up a Playground, simply paste the GraphQL endpoint (so, in your case that's the URL for the `Simple API` ) into the address bar of a browser.

![](http://imgur.com/vamb7WQ.png)

The left part of the Playground is for you to enter the queries and mutations you'd like to send to the GraphQL server. Right next to it on the right the responses sent by the server will be displayed. And finally, the rightmost area is for you to explore the documentation of the API, listing all available query, mutation and subscription fields.

If you want to create some initial data, feel free to send a couple of mutations through the Playground, e.g. for creating a new `Customer`:

```graphql
mutation {
  createCustomer(name: "Weird-Broccoli") {
    id
  }
}
```

After having created this `Customer` in the DB, you can convince yourself that the data was actually stored by either verifying it in the [data browser](https://www.youtube.com/watch?v=XeLKw2BSdI4&t=18s) or by sending the following query for which the response should will now include the newly created user:

```graphql
allCustomers {
  id
  name
}
```

## Wrap Up

That's it for today! We hope you enjoyed this first part of our tutorial series and learning about how to create a GraphQL server from the command line using `graphcool create`.

In the next chapter, we'll start writing some actual code. We are going to write some basic React components and integrate them with the Apollo client, also sending our first queries and mutations to interact with the API.

Let us know how you like the tutorial or ask any questions you might have. Contact us on [Twitter](www.twitter.com/graphcool) or join our growing community on [Slack](http://slack.graph.cool/)!

Until next time, stay (Graph)cool! 😎
