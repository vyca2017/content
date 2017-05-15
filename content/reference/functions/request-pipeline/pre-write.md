---
alias: phe1gei6io
path: /docs/reference/functions/request-pipeline/communicate-with-external-apis
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
tags:
  - functions
related:
  further:
  more:
---

# Communicate with External APIs

Functions used for the `PRE_WRITE` hook point are the last execution later before data is written to the database.
Here you can make calls to external services and modify data that is about to be persisted.

## Examples

#### Pass through

> The request is accepted.

```js
module.exports = function (input, logreq) {
  log(`input: ${input}`)

  return input
}
```

#### Call to External API

> Make a request to any third party API

```js
const request = require('request')

module.exports = function (input, log, cb) => {
  // query external movie API for number of stored actors
  const movieAPI = 'https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr'

  const query = `
    query {
      result: _allActorsMeta {
        count
      }
    }
  `
  request.post({
    url: movieAPI,
    headers: {
      'content-type': 'application/json',
    },
    body: JSON.stringify({ query }),
  }).on('error', (e) => {
    log('Error querying movieAPI: ' + e.toString())
    cb(e, {})
  }).on('data', (response) => {
    const actorCount = JSON.parse(response).data.result.count

    const data = {
      ...input.data,
      actorCount
    }
    cb(null, input.data.)
  })
}
```
