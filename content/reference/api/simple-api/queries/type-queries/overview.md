---
alias: chuilei3ce
path: /docs/reference/simple-api/type-queries
layout: REFERENCE
shorttitle: Type Queries
description: For every available type in your GraphQL schema, certain queries are automatically generated.
simple_relay_twin:
tags:
  - simple-api
  - queries
related:
  further:
  more:
---

# Type Queries in the Simple API

For every available [type](!alias-ij2choozae) in your [GraphQL schema](!alias-ahwoh2fohj), certain queries are automatically generated.

For example, if your schema contains a `Post` type:

```graphql
type Post {
  id: ID!
  title: String!
  description: String
}
```

the following type queries will be available:

* the `Post` query [to fetch a single node]().
* the `allPost` query [to fetch multiple nodes]().
