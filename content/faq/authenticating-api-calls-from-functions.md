---
alias: ahfah0joo1
path: /docs/faq/authenticating-api-calls-from-functions
layout: FAQ
description: Functions can hook into GraphQL events to implement custom business logic. Learn how authentication works with GraphQL in a serverless context.
tags:
  - platform
  - authentication
  - functions
  - clients
related:
  further:
    - eip7ahqu5o
    - wejileech9
    - koo4eevun4
  more:
---

# Authenticating API Calls From Functions

Functions are great for hooking into GraphQL events to implement custom business logic and as such, they usually act outside of traditional [user authentication](!alias-eixu9osueb). In this case, [permanent authentication token](!alias-eip7ahqu5o#token-types) are useful to provide your function with the needed access rights.

## Using A Permanent Authentication Token

Currently, permanent authentication tokens give you **full read/write access**, which is ideal for server-side functions. However, you need to make sure not to include the token anywhere public or client-side.

That's why you typically provide the authentication token as an *environment variable* or *encrypted secret* to the function. We show how to use environment variables with [stdlib](https://stdlib.com/) in this article. For alternative setups, look further down below.

After [creating a permanent authentication token](!alias-eip7ahqu5o#token-types) in the Console, you can use them for the `Authorization` header of the requests you send from your function.


## Configuring Environment Variables With stdlib

First, follow [the instructions on GitHub](https://github.com/stdlib/lib) to create a new stdlib function. To set up environment variables using stdlib, you can configure the `env.json` file.

Add your GraphQL endpoint and the permanent access token to the configuration file:

```json
{
  "dev": {
    "GRAPHQL_ENDPOINT": "https://api.graph.cool/simple/v1/__PROJECT_ID__",
    "PAT": "__TOKEN__"
  },
  "release": {
    "GRAPHQL_ENDPOINT": "https://api.graph.cool/simple/v1/__PROJECT_ID__",
    "PAT": "__TOKEN__"
  }
}
```

Then you can access the environment variables in the function itself using `process.env` in `index.js`. For example, a simple `allUsers` query using fetch:

```js
require('es6-promise').polyfill()
require('isomorphic-fetch')

const GRAPHQL_ENDPOINT = process.env.GRAPHQL_ENDPOINT
const PAT = process.env.PAT

module.exports = (params, callback) => {
  fetch(`${GRAPHQL_ENDPOINT}`, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${PAT}`
    },
    body: '{"query":"query { allUsers { id } }"}',
  })
    .then((response) => {
      if (response.status > 400) {
        throw new Error("Bad response from server")
      } else {
        return response.json()
      }
    })
    .then((response) => {
      callback(null, `Fetched ${response.data.allUsers.length} Users`)
    })
    .catch((error) => callback(error))
}
```

## Token-Based Authenciation Works Everywhere

Authenticating API calls in functions as described above works everywhere where you can send HTTP requests. Here's a quick overview of using environment variables or secrets in other common serverless code solutions:

* [Secrets for Auth0 webtask](https://webtask.io/docs/wt-cli)
* [Environment Variables in AWS Lambda](http://docs.aws.amazon.com/lambda/latest/dg/env_variables.html)
* [Secrets for Zeit now](https://zeit.co/blog/environment-variables-secrets)
