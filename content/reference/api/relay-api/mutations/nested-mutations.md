---
alias: yoo8vaifoa
path: /docs/reference/relay-api/nested-mutations
layout: REFERENCE
shorttitle: Nested Mutations
description: Create or update multiple nodes across relations all in a single mutation.
simple_relay_twin: ubohch8quo
tags:
  - relay-api
  - mutations
related:
  further:
    - oodoi6zeit
    - uath8aifo6
    - ek8eizeish
    - thaiph8ung
    - da7pu3seew
  more:
    - cahzai2eur
    - dah6aifoce
    - vietahx7ih
---

# Nested Create Mutations

When creating or updating nodes, you can connect it to an existing related node or create a new related node that will be connected as well.

### Nested Create Mutations

For every relation of a type, the `update` and `create` mutations expose an argument to issue a nested create operation on the related type. Depending on the relation multiplicity, this argument allows to either create a single related node (for to-one relations) or multiple related nodes (for to-many relations).

[Read more about nested create mutations](!alias-ma6eijae7a).

### Nested Update Mutations

For every relation of a type, the `update` and `create` mutations expose an argument to connect the original node to an existing related node. Depending on the relation multiplicity, this argument allows to either add a single related node (for to-one relations) or multiple related nodes (for to-many relations) to the relation.

[Read more about nested update mutations](!alias-ec6aegaiso).
