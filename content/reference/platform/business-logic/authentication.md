---
alias: wejileech9
path: /docs/reference/platform/authentication
layout: REFERENCE
description: Authentication allows you to manage users in your GraphQL backend. Use authentication provides like Auth0 and Digits out-of-the-box.
tags:
  - platform
  - authentication
  - auth-providers
  - session-user
  - tokens
related:
  further:
    - eixu9osueb
    - iegoo0heez
    - uh8shohxie
  more:
    - pheiph4ooj
    - goij0cooqu
    - thoh9chaek
---

# Authentication

## Auth Providers

Authentication is provided by means of so called auth providers. They can be configured in the `User` model of your project and multiple auth providers can be enabled at the same. However, one user can only authenticate with one auth provider at the same time.

### Email and Password

Email/password-based authentication. You can enable this auth provider without providing any additional information.
Read how to use the `createUser` and `signinUser` mutations to create or signin users respectively in the [Simple API](!alias-eixu9osueb#email-and-password) and [Relay API](!alias-yoh9thaip0#email-and-password).

### Digits Phone Verification

[Digits](https://get.digits.com/) is an external auth provider that allows your users to authenticate with a phone. You need a consumer key and a consumer secret to enable this auth provider which you can obtain after creating a new application at Digits. Read how to use the `createUser` and `signinUser` mutations to create or signin users respectively in the [Simple API](!alias-eixu9osueb#digits-phone-verification) and [Relay API](!alias-yoh9thaip0#digits-phone-verification).

### Auth0 Social Logins

[Auth0](https://auth0.com/) is an external auth provider that allows your users to authenticate with different social logins like Facebook, Google, Twitter or other methods like Passwordless. You need a domain, a client id and a client secret to enable this auth provider which you can obtain after creating a new client at Auth0. Read how to use the `createUser` mutation to create users in the [Simple API](!alias-eixu9osueb#auth0-social-logins) and [Relay API](!alias-yoh9thaip0#auth0-social-logins).

## Session User

A user is considered to be signed in during a request, if the user is identified by the authentication token supplied to the request.
If an invalid or no authentication token is supplied to a request, the request is granted [`EVERYONE` permission](permissions#permission-level)

To allow users to login or sign up you might want to setup the according [permissions](permissions) and setup an auth provider within the [Simple API](!alias-eixu9osueb) or [Relay API](!alias-yoh9thaip0).

## Authenticating requests

Request authentication is handled using *authentication tokens* which grant role-based access to the data of your project.

They have to be supplied using the `Authorization` header of your http requests:

```plain
Authorization: Bearer <authentication token>
```

If a request to your endpoint contains a valid authentication token, it is granted certain [permissions](permissions) that you can configure on a field granularity. If a request to your endpoint contains an invalid authentication token, all operations available to not authenticated users will be executed, public data will be returned, and an error is additionally returned.

## Temporary Authentication Token

Temporary authentication tokens have a certain validity duration and can be obtained from authentication mutations.
To enable an auth provider, head over to the [`User` model](system-artifacts) in your project and choose between different options.

Read more about how user authentication works with different auth providers in the [Simple API](!alias-eixu9osueb) and [Relay API](!alias-yoh9thaip0).

## Permanent Authentication Token

You can create *permanent authentication tokens* in the Console for server-side services that need access to your data.

Note: Be **very** careful where you use the permanent authentication tokens. Everyone with a permanent authentication token can do serious harm to your data, so you should never include them anywhere client-side, like on a website or a mobile app.
