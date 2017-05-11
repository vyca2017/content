---
alias: peyaaph9vi
path: /docs/reference/relay-api/session-user
layout: REFERENCE
shorttitle: The session user
description: Query the signed in user in the Relay API. The user needs to be registered with an authentication provider like Auth0 in your GraphQL backend.
simple_relay_twin: gieh7iw2ru
tags:
  - relay-api
  - queries
  - authentication
  - session-user
related:
  further:
    - wejileech9
    - yoh9thaip0
    - iegoo0heez
    - aechiosh8u
  more:
    - goij0cooqu
    - cahzai2eur
---

# The session user in the Relay API

If the request of a query or mutation contains authentication information on the [session user](!alias-wejileech9#session-user), you can use the `user` query to query information on that user. All fields of the `User` type are available. Depending on the [auth providers](!alias-wejileech9#auth-providers) you enabled, you can additionally include different fields in the query.

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  viewer {
    user {
      id
    }
  }
}
---
{
  "data": {
    "viewer": {
      "user": {
        "id": "my-user-id"
      }
    }
  }
}
```

If no user is signed in, the query response will look like this:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
query {
  viewer {
    user {
      id
    }
  }
}
---
{
  "data": {
    "viewer": {
      "user": null
    }
  }
}
```

Note that you have to set appropriate [permissions](!alias-iegoo0heez) on the `User` type to use the `user` query.
