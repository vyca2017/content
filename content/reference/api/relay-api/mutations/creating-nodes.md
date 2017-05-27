---
alias: oodoi6zeit
path: /docs/reference/relay-api/creating-nodes
layout: REFERENCE
shorttitle: Creating nodes
description: Creates a new node for a specific type in your GraphQL backend. The node gets assigned a unique node id on creation.
simple_relay_twin: wooghee1za
tags:
  - relay-api
  - mutations
related:
  further:
    - oojie3ooje
    - uath8aifo6
    - thaiph8ung
  more:
    - cahzai2eur
    - dah6aifoce
---

# Creating a node

Creates a new node for a specific type that gets assigned a new `id`.
All [required](!alias-teizeit5se#required) fields of the type without a [default value](!alias-teizeit5se#default-value) have to be specified, the other fields are optional arguments.

The query response can contain all fields of the newly created node, including the `id` field.

## Create a new node

> Create a new post and query its id:

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

## Connecting a new node to another node

When creating a node you can directly connect it to another node on the one-side of a [relation](!alias-goh5uthoc1). You can either choose to connect it to an existing node, or even create the node yourself.

Note: This works for one-to-one and one-to-many relations but not for many-to-many relations.

### Connecting to an existing node

> Create a new post and connect it to an existing author:

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
    authorId: "cixnekqnu2ify0134ekw4pox8"
    clientMutationId: "abc"
  }) {
    post {
      id
      slug
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

### Nested mutation to create two related nodes

> Create a new post and connect it to a new meta information node:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
createPost(input: {
    title: "My great Vacation"
    slug: "my-great-vacation"
    published: true
    text: "Read about my great vacation."
    metaInformation: {
      tags: [TRAVELLING]
    }
    clientMutationId: "abc"
  }) {
    post {
      id
      slug
    }
}
---
{
  "data": {
    "createPost": {
      "post": {
        "id": "cixoz7xxr03tx0156fti3nqmn",
        "slug": "delete meeeee"
      }
    }
  }
}
```
