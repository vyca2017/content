---
alias: ecoos0ait6
path: /docs/reference/functions/request-pipeline/transform-mutation-payloads
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
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
  return {
    event: event
  }
}
```
