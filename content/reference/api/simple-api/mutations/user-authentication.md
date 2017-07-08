---
alias: eixu9osueb
path: /docs/reference/simple-api/user-authentication
layout: REFERENCE
shorttitle: User authentication
description: Create new users and allow them to sign in. Available authentication methods are Auth0, Digits and email login, depending on your project setup.
simple_relay_twin: yoh9thaip0
tags:
  - simple-api
  - mutations
  - queries
  - authentication
  - auth-providers
related:
  further:
    - wejileech9
    - iegoo0heez
  more:
    - goij0cooqu
    - pheiph4ooj
    - thoh9chaek
---

# User Authentication with the Simple API

The `createUser` and `signinUser` mutations that provide you with a way to create and sign in users respectively depend on your enabled [auth providers](!alias-seimeish6e#authentication-providers). You can enable multiple or just one auth provider, however you can only use one auth provider per user.

As any other `create` mutation, `createUser` returns the newly created `User` node.

For Email and Digits, the `signinUser` mutation returns a [temporary authentication token](!alias-wejileech9) that can be used to authenticate the user in further queries or mutations. For Auth0, you can use the same token for creating a new user and authenticating a request.

## Permission setup

Auth providers need an appropriate [permission setup](!alias-geekae9gah) to work correctly.

## Email and Password

Read the [guide for email authentication in React and Apollo](!alias-oopheesaj9).

**Creating a User**

To create a new user with email and password, enable the built-in email and password auth provider, and provide an `email` and `password` to the `createUser` mutation:

```graphql
mutation {
  createUser(authProvider: {
    email: {
      email: "user@email.com"
      password: "secret-password"
    }
  }) {
    id
  }
}
```

**Signing in a User**

To sign in an existing user with email and password, provide his `email` and `password` to the `signinUser` mutation:

```graphql
mutation {
  signinUser(email: {
    email: "user@email.com"
    password: "secret-password"
  }) {
    token
  }
}
```

Now you can use the obtained token in your header when making requests to [authenticate the request](!alias-wejileech9).
The token has an expiration duration of 30 days.

### Digits Phone Verification

Read the [guide for Digits authentication in React and Apollo](!alias-quohtu9soo).

If you want to enable Digits Phone Verification to authenticate your users, you need to provide your Digits consumer key and consumer secret in the Auth provider configuration dialog.

**Creating a User**

To create a new user with Digits, provide the `apiUrl` and `credentials` tokens that were assigned to your application from Digits to the `createUser` mutation:

```graphql
mutation {
  createUser(authProvider: {
    digits: {
      apiUrl: "<apiUrl>"
      credentials: "<credentials>"
    }
  }) {
    id
  }
}
```

**Signing in a User**

To sign in an existing user with Digits, provide his `apiUrl` and `credentials` to the `signinUser` mutation:

```graphql
mutation {
  signinUser(digits: {
    apiUrl: "<apiUrl>"
    credentials: "<credentials>"
  }) {
    token
  }
}
```

Now you can use the obtained token in your header when making requests to [authenticate the request](!alias-wejileech9).
The token has an expiration duration of 30 days.

### Auth0 Social Logins

Read the [guide for Auth0 authentication in React and Apollo](!alias-pheiph4ooj).

If you want to enable Auth0 Social Logins to authenticate your users, you need to provide your Auth0 id in the Auth provider configuration dialog.

**Creating a User**

To create a new user provide the `idToken` token obtained from Auth0:

```graphql
mutation {
  createUser(authProvider: {
    auth0: {
      idToken: "<idToken>"
    }
  }) {
    id
  }
}
```

**Signing in a User**

No special step is needed to obtain a token for Auth0. You can use the same `idToken` to [authenticate a request](!alias-wejileech9) that you would use for the `createUser` mutation. You can configure the expiration duration of these tokens in the settings of your Auth0 account.

### Create User and Sign in afterwards

You might want to create a user and sign him in right afterwards. You can include both the `createUser` mutation and the `signinUser` mutation in the same request:

```graphql
mutation {
  createUser(authProvider: {
    email: {
      email: "user@email.com"
      password: "secret-password"
    }
  }) {
    id
  }
  signinUser(email: {
    email: "user@email.com"
    password: "secret-password"
  }) {
    token
  }
}
```

This works because multiple mutations included in the same request are being run sequentially.
If you want to create a user with credentials that already exist, an error is returned from the API. You can catch this error and prompt your user to sign in instead.
