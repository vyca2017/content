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

# Relay vs. Apollo - Comparing GraphQL Clients

With JavaScript you have a few choices to connect to a GraphQL backend.
Using HTTP clients like `fetch` or `request` can get you quite far when all you need is sending queries or mutations. However, you have to handle things like escaping for query arguments by hand, which can become quite tedious.

The two most popular GraphQL clients right now are [Relay](https://facebook.github.io/relay/) and [Apollo Client](http://dev.apollodata.com/). Both offer several advanced features to benefit the most from using GraphQL, such as **client-side caching and optimistic updates**.

> This article won't tell you which GraphQL client is "the better one" but objectively compares the differences (advantages/disadantages) between Relay and Apollo Client from several perspectives.

## Requirements

Both Relay and Apollo Client are used best in combination with React. However, Apollo Client offers several integrations for other development environments. Furthermore, Relay is opinionated about the GraphQL server.

Read more about the [requirements for Relay and Apollo Client](!alias-iep9yi0ri6). The following points are covered:

* What environment setup is needed?
* What requirements does the GraphQL server have?

## Queries

Apollo Client and Relay allow you to send GraphQL queries by means of React higher-order components (HOC).
Queries are used to fetch data from a GraphQL server. Both GraphQL clients integrate nicely with the React lifecycle and offer GraphQL fragment usage.

Read about [GraphQL queries in Apollo Client and Relay](!alias-iph7aevae7):

* How can queries be sent to the GraphQL backend?
* What happens with the query response?
* How do GraphQL fragments come into play?

## Mutations

Apollo Client and Relay handle GraphQL mutations very differently. Relay requires you to describe the mutation based on a versatile but difficult-to-grasp API. This helps Relay to keep the cache consistent when a node is created or modified. Apollo Client on the other hand makes calling mutations very easy but requires extra work on the client for a consistent cache.

Read about [GraphQL mutations in Apollo Client and Relay](!alias-koht6ethe3):

* How can mutations be sent to the GraphQL server?
* What happens with the query response?
* What about optimistic responses?


## More topics

Apollo Client and Relay can be compared from further perspectives. [Chat with us in Slack](https://slack.graph.cool) if you have a topic suggestion.

* Server side rendering (SSR)
* Subscriptions
* Cache capabilities
* Pagination
* Conventions
* Debugging
