---
alias: ubohch8quo
path: /docs/reference/simple-api/nested-mutations
layout: REFERENCE
shorttitle: Nested Mutations
description: Create or update multiple nodes across relations all in a single mutation.
simple_relay_twin: yoo8vaifoa
tags:
  - simple-api
  - mutations
related:
  further:
    - wooghee1za
    - cahkav7nei
    - koo4eevun4
    - ofee7eseiy
    - zeich1raej
  more:
    - cahzai2eur
    - dah6aifoce
    - vietahx7ih
---

# Nested Mutations

When creating or updating nodes, you can connect it to an existing related node or create a new related node that will be connected as well.

### Nested Create Mutations

For every relation of a type, the `update` and `create` mutations expose an argument to issue a nested create operation on the related type. Depending on the relation multiplicity, this argument allows to either create a single related node (for to-one relations) or multiple related nodes (for to-many relations).

[Read more about nested create mutations](!alias-vaet3eengo).

### Nested Update Mutations

For every relation of a type, the `update` and `create` mutations expose an argument to connect the original node to an existing related node. Depending on the relation multiplicity, this argument allows to either add a single related node (for to-one relations) or multiple related nodes (for to-many relations) to the relation.

[Read more about nested update mutations](!alias-tu9ohwa1ui).
