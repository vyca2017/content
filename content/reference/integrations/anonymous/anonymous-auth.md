---
alias: ieph6iujah
path: /docs/reference/integrations/anonymous-auth
layout: REFERENCE
description: The Anonymous Authentication allows you to store data for users that are identified by a client-side generated unique secret.
tags:
  - integrations
  - authentication
related:
  further:
  more:
---

# Anonymous Authentication

The **Anonymous Authentication** allows you to store data for users that are identified by a client-side generated unique secret rather than credentials the users enter themselves. You can attach it to any [type]() in your data schema.

## Activating the Anonymous Authentication

Select the type the anonymous authentication should be attached to in the [Integration View]().

![](./anonymous-auth.png?width=400)

If you attach it to the `User` type, this adds the `authenticateAnonymousUser` mutation to your [API](!alias-heshoov3ai).
Additionally, the [fields]() `secret: String!` and `isVerified: Boolean!` are added to the selected type.
