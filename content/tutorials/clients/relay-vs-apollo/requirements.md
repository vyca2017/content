---
alias: iep9yi0ri6
path: /docs/tutorials/relay-vs-apollo-requirements
layout: TUTORIAL
preview: relay-vs-apollo.png
description: 'Relay vs. Apollo Client: Relay and Apollo Client have different requirements for the development environment they can be used in.'
tags:
  - clients
  - relay
  - apollo-client
related:
  further:
    - heshoov3ai
    - aizoong9ah
  more:
    - iu5niesain
    - iph7aevae7
    - koht6ethe3
    - tioghei9go
---

# Relay vs. Apollo - Requirements

## Frontend framework

Both Relay and Apollo work great with React. The general idea is that React components are wrapped using a higher order component provided by the GraphQL client that gets notified whenever the props of the inner component are about to change. A query is defined using these props and the data query response is then injected into the inner component using another prop.

However, Relay is tightly coupled to React. Aside from React Native, Relay cannot be used in another environment. Furthermore, setting up a [babel plugin](https://github.com/graphcool/babel-plugin-react-relay) is necessary to use Relay.

Apollo Client on the other hand is relying on one core library `apollo-client` that is even compatible with VanillaJS. Additionally, a wide range of integrations for different frontend frameworks exist, such as `react-apollo` (the most mature one), `angular-apollo`, `apollo-ios` as well as `vue-apollo`.

## GraphQL schema structure

Relay requires a specific structure of the GraphQL schema exposed by the GraphQL server while Apollo doesn't. Graphcool projects offer a Relay conforming GraphQL schema through the Relay API. A valid query looks like this:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  viewer {
    allPosts {
      edges {
        node {
          id
        }
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "allPosts": {
        "edges": [
          {
            "node": {
              "id": "cixnen24p33lo0143bexvr52n"
            }
          },
          {
            "node": {
              "id": "cixnenqen38mb0134o0jp1svy"
            }
          },
          {
            "node": {
              "id": "cixneo7zp3cda0134h7t4klep"
            }
          }
        ]
      }
    }
  }
}
```

Note how the top-level query is `viewer` and how the result of `allPosts` is structured in `edges` and `node`. Additionally, Relay requires the `id` field on a node. You can learn more [about these terms](!alias-tioghei9go) and [browse the official Relay specification](https://facebook.github.io/relay/docs/graphql-relay-specification.html) to find out more.

The analogous query in the Simple API looks like this:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
---
query {
  allPosts {
    id
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

The query is following a simpler structure - giving the Simple API its name.
Apollo doesn't require any specific schema setup and therefore works with both the Relay API and the Simple API.
