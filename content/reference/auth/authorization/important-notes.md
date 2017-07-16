---
alias: aej3ne1eez
path: /docs/reference/auth/important-notes
layout: REFERENCE
description: Graphcool features a simple yet powerful permission system that integrates seamlessly with the available authentication providers.
tags:
  - permissions
  - authorization
related:
  further:
  more:
---

# Important Notes

* For create mutations, all scalar fields can be returned in the mutation payload without resulting in a permission error. This is independent of the permission setup.

> Note: this currently does not apply to the `createUser` mutation.
