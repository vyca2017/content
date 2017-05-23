---
alias: caich7oeph
path: /docs/reference/functions/request-pipeline/transform-input-arguments
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
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
module.exports = function (event, cb) {
  console.log(`event: ${event}`)

  return {data: event.data}
}
```

#### Computed Fields

> Some of the input arguments are used to compute a different input argument.

```js
module.exports = function (event, cb) {
  console.log('Compute area')
  var area = event.data.width * event.data.length
  data = Object.assign({}, event.data, area)

  return {data}
}
```

#### Input Validation

> Reject further processing of the incoming GraphQL mutation by [throwing an error](!alias-quawa7aed0).

```js
module.exports = function (event, cb) {
  if (event.data.length < 0 || event.data.width < 0) {
    return {
      error: 'Length and width must be greater than 0!'
    }
  }

  return event
}
```
