---
alias: goij0cooqu
path: /docs/faq/graphcool-session-user
layout: FAQ
title: How to query the currently logged-in user?
shorttitle: Querying the logged-in user
description: Learn how to send a GraphQL query to fetch signed in users that are registered with an authentication provider like Auth0 or Digits.
tags:
  - platform
  - client-apis
  - queries
  - authentication
related:
  further:
    - wejileech9
    - iegoo0heez
    - eixu9osueb
  more:
    - pheiph4ooj
    - thoh9chaek
---


# How to query the currently logged-in user?

If new users want to sign up at your application, you can use one of the available [auth providers](!alias-seimeish6e#authentication-providers) to add them to your Graphcool project. Then they can later receive a [temporary authentication token](!alias-eip7ahqu5o#token-types) by logging in to your application.

## Querying the user making a request

In both the [Simple API](!alias-heshoov3ai) and the [Relay API](!alias-aizoong9ah), you can query the user making a request with the `user` query.

To query the id of the logged-in user in the Simple API:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  user {
    id
  }
}
---
# null if no valid user could be determined - otherwise, returns an id
{
  "data": {
    "user": null
  }
}
```

and in the Relay API:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  viewer {
    user {
      id
    }
  }
}
---
# null if no valid user could be determined - otherwise, returns an id
{
  "data": {
    "user": null
  }
}
```

## How is the logged-in user determined?

Requests at Graphcool are authenticated by supplying an [authentication token](!alias-wejileech9#authenticating-requests) in the `Authorization` header.

If the token is valid, any operation included in the request will be granted `AUTHENTICATED` permissions and the `user` query from above returns information for the user identified by the token. If the token does not belong to a registered user in your project or it has expired, no valid user can be determined.
