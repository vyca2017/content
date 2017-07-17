---
alias: caich7oeph
path: /docs/reference/functions/request-pipeline/transform-input-arguments
layout: REFERENCE
description: Use Graphcool Functions to validate or transform input arguments of a GraphQL mutation synchronously.
tags:
  - functions
related:
  further:
  more:
---

# Transform Input Arguments

Functions used for the `TRANSFORM_ARGUMENT` hook point can do arbitrary transformations on input arguments or abort an incoming GraphQL mutation all together.

## Examples

#### No Transformation

> The request is not modified at all.

```js
module.exports = function (event) {
  console.log(`event: ${event}`)

  return {data: event.data}
}
```

#### Computed Fields

> Some of the input arguments are used to compute a different input argument.

```js
module.exports = function (event) {
  console.log('Compute area')
  event.data.area = event.data.width * event.data.length

  return event
}
```

#### Input Validation

> Reject further processing of the incoming GraphQL mutation by [throwing an error](!alias-quawa7aed0).

```js
module.exports = function (event) {
  if (event.data.length < 0 || event.data.width < 0) {
    return {
      error: 'Length and width must be greater than 0!'
    }
  }

  return event
}
```
