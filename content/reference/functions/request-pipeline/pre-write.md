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

#### No Transformation

> The request is not modified at all.

```js
module.exports = function (event) {
  return {
    event: event
  }
}
```

#### Call to External API

```js
require('isomorphic-fetch')

module.exports = async (event) => {
  // query external movie API for number of stored actors
  const movieAPI = 'https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr'

  const query = `
    query {
      result: _allActorsMeta {
        count
      }
    }
  `

  const response = await fetch(movieAPI, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ query })
  }).then((response) => (response.json()))

  const actorCount = response.data.result.count

  event.data.actorCount = actorCount

  return {
    event: event
  }
}
```
