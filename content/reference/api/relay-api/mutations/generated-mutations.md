---
alias: vah0igucil
path: /docs/reference/relay-api/mutations
layout: REFERENCE
description: Use mutations to modify data. Mutations in the GraphQL schema of your project are derived from types and relations that you defined.
simple_relay_twin: ol0yuoz6go
tags:
  - relay-api
  - mutations
related:
  further:
    - oodoi6zeit
    - uath8aifo6
    - oojie3ooje
  more:
    - saigai7cha
    - dah6aifoce
---

# Mutations

With a *mutation* you can modify the data of your project.
Similar to queries, all mutations are automatically generated. Explore them by using the [playground](!alias-oe1ier4iej) inside your project.

This is an example mutation:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  createPost(input: {
    title: "My great Vacation"
    slug: "my-great-vacation"
    published: true
    text: "Read about my great vacation."
    clientMutationId: "abc"
  }) {
    post {
      id
    }
  }
}
---
{
  "data": {
    "createPost": {
      "post": {
        "id": "cixneo7zp3cda0134h7t4klep",
        "slug": "my-great-vacation"
      }
    }
  }
}
```

Every mutation has to include the `clientMutationId` argument. If you are running the mutation in the playground, you can choose some arbitrary value like `clientMutationId: "abc"` for this argument. If you run a mutation with Relay, the `clientMutationId` is automatically filled by Relay.

Note: The subselection of fields cannot be empty. If you have no specific data requirements, you can just select an arbitrary field.

## Modifying nodes

For every [type](!alias-ij2choozae) in your project, there are different mutations to

* [Create nodes](!alias-oodoi6zeit)
* [Updating nodes](!alias-uath8aifo6)
* [Deleting nodes](!alias-oojie3ooje)

## Modifying edges

For every [relation](!alias-goh5uthoc1) in your project, there are mutations to connect and disconnect related nodes via an edge. The actual mutations depend on the multiplicity relations, so there are the following cases:

* [modifying edges for one-to-one relations](!alias-da7pu3seew)
* [modifying edges for one-to-many relations](!alias-ek8eizeish)
* modifying edges for many-to-many relations

## User Authentication

Mutations related to [user authentication](!alias-yoh9thaip0) allow you to create new users or sign in existing users.

## File Management

Mutations related to [file management](!alias-aechiosh8u) allow you to upload, rename or delete files.
