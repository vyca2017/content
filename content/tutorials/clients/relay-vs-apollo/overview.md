---
alias: iu5niesain
path: /docs/tutorials/relay-vs-apollo-overview
layout: TUTORIAL
preview: relay-vs-apollo.png
description: 'Relay vs. Apollo Client: Find out which GraphQL client works best for you by learning about differences between Relay and Apollo Client.'
tags:
  - clients
  - queries
  - mutations
  - relay
  - apollo-client
related:
  further:
  - heshoov3ai
  - aizoong9ah
  more:
    - iep9yi0ri6
    - iph7aevae7
    - koht6ethe3
    - tioghei9go
    - voht5ach9i
---

# Relay vs. Apollo - Overview

With JavaScript you have a few choices to connect to a GraphQL backend.
Using http clients like `fetch` or `request` can get you quite far when all you need is sending queries and mutations.
However, you have to handle things like escaping for query arguments yourself, which can become quite tedious.

The two most popular GraphQL clients right now are [Relay](https://facebook.github.io/relay/) and [Apollo Client](http://dev.apollodata.com/). Both offer several advanced features to benefit the most from using GraphQL, such as client-side caching and optimistic updates.

Instead of giving a distinct answer on which GraphQL client is the better one, we will compare the differences between Relay and Apollo Client from several perspectives. Because both Relay and Apollo Client run best in combination with React, most subsections will compare Relay with the `react-apollo` integration of Apollo Client.

It should be noted though that outside of React and React Native, Relay cannot be used at all while Apollo Client offers several integrations for other environments, such as Angular 2 or iOS.

## Requirements

* What environment setup for the frontend application is needed to be able to use the GraphQL client?
* What setup for the GraphQL server is needed?

Read more about [requirements for Relay and Apollo Client](!alias-iep9yi0ri6).

## Queries

* How can queries be sent to the GraphQL backend?
* What happens with the query response?
* How do GraphQL fragments come into play?

Read more about [GraphQL queries in Apollo Client and Relay](!alias-iph7aevae7).

## Mutations

* How can mutations be sent to the GraphQL server?
* What happens with the query response?
* What about optimistic responses?

Read more about [GraphQL mutations in Apollo Client and Relay](!alias-koht6ethe3).

## More topics

Apollo Client and Relay can be compared from further perspectives. [Chat with us in Slack](https://slack.graph.cool) if you have a topic suggestion.

* Server side rendering (SSR)
* Subscriptions
* Cache capabilities
* Pagination
* Conventions
* Debugging
