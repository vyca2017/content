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

In this first part of our tutorial series, we're focussing on generating a data model from a set of requirements that we have for the Freecom app.

### Features

We have a few requirements for the app, here's a list of features we want to implement:

- A customer visits a website and can open the support window
- The support window displays a list of the customer's previous conversations with support agents if any, or otherwise directly opens a new conversation
- The customer can either continue one of the existing conversations or initiate a new one
- A support agent interacts through Slack with customers on the website
- Every conversation happens in one dedicated Slack channel
- Every conversation is associated with one customer and one support agent
- The support agent of a conversation can change any time if a different support agent responds in a Slack channel
- One support agent can engage in multiple conversations at a time
- A customer can upload files that the support agents can access

### Designing the GraphQL Schema

The [GraphQL schema](!alias-ahwoh2fohj) represents the _data model_ of an application. It defines the _structure_ of the information that we can retrieve from the backend. Let's try to translate the above requirements into appropriate entities that we will then use to set up the GraphQL API.

#### `Customer`

Our first type is a `Customer`. A customer has a `name` property and is associated with a list of `conversations `.

```graphl
type Customer {
  name: String!
  conversations: [Conversation!]! @relation(name: "ConversationsFromCustomer")
}
```

The `name` will be randomly generated for each customer, so that there is no overhead for them and they can start asking questions right away.

#### `Agent`

Similarly, the `Agent` type represents the _support agents_. Since the support agents will use Slack, they have two fields that represent their Slack identity: `slackUserId` and `slackUserName`.  

Each `Agent` is associated with the list of conversations that they're currently engaged in. However, since the agent that participates in a conversation can potentially change, we also maintain a list of `messages` that each agent sent in their chats. That is so that it's possible to clearly identify the sender of a message. Note that we didn't need to associate the `Customer` with any messages because the `customer` on a `Conversation` can never change, so we always know who was the customer that sent a specific message by tracing back through the `Conversation`.

```graphql
type Agent {
  slackUserId: String!
  slackUserName: String!
  conversations: [Conversation!]! @relation(name: "ConversationsFromAgent")
  messages: [Message!]! @relation(name: "MessagesFromAgents")
}
```

Everyone joining the Slack channel will be able to act as a support agent using a specific command when sending a message.

#### `Conversation`

A `Conversation` is associated with one `Customer`, one `Agent` and a list of `messages`.

In general, there will be _one Slack channel per conversation_. The name of a Slack channel is derived from the customer's name and and index that increments with every new conversation the customer initiates, so e.g. `cool-tomato-1` would be the Slack channel that represents the very first conversation of the customer named `cool-tomato`. We thus store the `slackChannelIndex` as specific field on the `Conversation` type.

Notice that the `agent` associated with the conversation might change, while the `customer` will always be the same.

```graphl
type Conversation {
  slackChannelIndex: Int!
  customer: Customer @relation(name: "ConversationsFromCustomer")
  agent: Agent @relation(name: "ConversationsFromAgent")
  messages: [Message!]! @relation(name: "MessagesInConversation")
}
```

#### `Message`

A `Message` only has one property `text` that represents the content of the message. It is further related to a `Conversation` and potentially to an `agent`. Notice that the `agent` field can be `null`! This is how we'll know whether a `Message` was sent either by a `Customer` or by an `Agent` - if the `agent` field is `null`, the `Message` must have been sent by a `Customer` which we can access through the associated `conversation` field.

```graphql
type Message {
  text: String!
  agent: Agent @relation(name: "MessagesFromAgents")
  conversation: Conversation @relation(name: "MessagesInConversation")
}
```
