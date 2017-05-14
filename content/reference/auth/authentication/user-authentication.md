---
alias: geekae9gah
path: /docs/reference/auth/authentication
layout: REFERENCE
description: Authentication allows you to manage users in your GraphQL backend. Use authentication providers like Auth0 and Digits out-of-the-box.
tags:
  - authentication
related:
  further:
  more:
---

# Authentication

## Signup

Depending on the enabled [auth providers]() you can use different versions of the `createUser` mutation to create and sign up a new user at the same time.

To allow the creation of new user accounts to everyone, you need to setup your [permissions]() so that `EVERYONE` can call the `createUser` mutation.

## User Login

The [API]() is stateless - that means that users are not considered logged in or logged out per se. In fact, only requests can be considered authenticated or not. In an application, a user can therefor be seen as logged in if she is in possession of [a valid authentication token]() associated with her account.

You can use the [`user` query]() to validate a given token. For valid tokens, it returns user data, while invalid tokens return no data.
