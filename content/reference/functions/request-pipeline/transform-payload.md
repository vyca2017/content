---
alias: ecoos0ait6
path: /docs/reference/functions/request-pipeline/transform-mutation-payloads
layout: REFERENCE
description: Use Graphcool Functions to transform the payload of a GraphQL mutation synchronously.
tags:
  - functions
related:
  further:
  more:
---

# Transform Mutation Payloads

Functions used for the `TRANSFORM_PAYLOAD` hook point can do arbitrary transformations on the [mutation payload](!alias-gahth9quoo) after a mutation has been successfully executed.

## Examples

#### No Transformation

> The request is not modified at all.

```js
module.exports = function (event) {
  console.log(`event: ${event}`)

  return event
}
```

#### Flip a boolean

> A boolean contained in the input arguments is flipped.

```js
module.exports = function (event) {
  console.log(`event: ${event}`)

  event.data.isPaid = !event.data.isPaid

  return event
}
```

## Current Limitations

Currently, **only fields that are already part of the mutation payload can be modified**. No fields can be added or removed.
