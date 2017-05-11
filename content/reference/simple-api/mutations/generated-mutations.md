---
alias: ol0yuoz6go
path: /docs/reference/simple-api/mutations
layout: REFERENCE
description: Use mutations to modify data. Mutations in the GraphQL schema of your project are derived from types and relations that you defined.
simple_relay_twin: vah0igucil
tags:
  - simple-api
  - mutations
related:
  further:
    - wooghee1za
    - fasie2rahv
    - cahkav7nei
  more:
    - saigai7cha
    - dah6aifoce
---

# Mutations in the Simple API

With a *mutation* you can modify the data of your project.
Similar to queries, all mutations are automatically generated. Explore them by using the [playground](!alias-uh8shohxie#playground) inside your project.

This is an example mutation:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  createPost(
    title: "My great Vacation"
    slug: "my-great-vacation"
    published: true
    text: "Read about my great vacation."
  ) {
    id
    slug
  }
}
---
{
  "data": {
    "createPost": {
      "id": "cixneo7zp3cda0134h7t4klep",
      "slug": "my-great-vacation"
    }
  }
}
```

Note: The subselection of fields cannot be empty. If you have no specific data requirements, you can always select `id` as a default.

## Modifying nodes

For every [type](!alias-ij2choozae) in your project, there are different mutations to

* [Create nodes](!alias-wooghee1za)
* [Updating nodes](!alias-cahkav7nei)
* [Deleting nodes](!alias-fasie2rahv)

## Modifying edges

For every [relation](!alias-goh5uthoc1) in your project, there are mutations to connect and disconnect related nodes via an edge. The actual mutations depend on the multiplicity relations, so there are the following cases:

* [modifying edges for one-to-one relations](!alias-zeich1raej)
* [modifying edges for one-to-many relations](!alias-ofee7eseiy)
* modifying edges for many-to-many relations

## User Authentication

Mutations related to [user authentication](!alias-eixu9osueb) allow you to create new users or sign in existing ones.

## File Management

Mutations related to [file management](!alias-eetai5meic) allow you to upload, rename or delete files.
