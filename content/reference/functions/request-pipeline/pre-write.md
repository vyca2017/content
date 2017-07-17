---
alias: phe1gei6io
path: /docs/reference/functions/request-pipeline/communicate-with-external-apis
layout: REFERENCE
description: Use Graphcool Functions to initiate external workflows before data is written to the database.
tags:
  - functions
related:
  further:
  more:
---

# Communicate with External APIs

Functions used for the `PRE_WRITE` hook point are the last execution layer before data is written to the database.
Here you can initiate workflows for external services, like sending an email, charging a credit card or abort the processing of a request based on the result of external APIs.

> In the `PRE_WRITE` hook points, data transformations are ignored. If you want to transform input data, refer to the `TRANSFORM_ARGUMENT` hook point.

## Examples

#### Pass through

> The request is accepted.

```js
module.exports = function (event) {
  console.log(`event: ${event}`)

  return {data: event.data}
}
```

#### Call to External API

> Make a request to any third party API

```js
require('isomorphic-fetch')

// only allow current mutation if more than 3 movies exist in external API
module.exports = function (event) => {
  var movieAPI = 'https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr'

  var query = `
    query {
      result: _allActorsMeta {
        count
      }
    }
  `

  return fetch(movieAPI, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ query })
  }).then((response) => {
    return response.json()
  }).then((data) => {
    if (data.data.result.count > 3) {
      return event
    } else {
      return {error: `Could not finish mutation, because only ${data.data.result.count} movies exist.`}
    }
  }).catch((error) => {
    console.log(error)
    return {error: 'Could not connect to Movie API'}
  })
}
```
