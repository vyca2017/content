---
alias: ec6aegaiso
path: /docs/reference/relay-api/nested-update-mutations
layout: REFERENCE
shorttitle: Nested Update Mutations
description: Update multiple nodes across relations all in a single mutation.
simple_relay_twin: tu9ohwa1ui
tags:
  - relay-api
  - mutations
  - update
related:
  further:
    - uath8aifo6
  more:
    - cahzai2eur
    - saigai7cha
    - dah6aifoce
    - vietahx7ih
---

# Nested Update Mutations in the Relay API

Nested update mutations connect the original node to an existing node in the related model.
Let's assume the following schema:

```idl
type Author {
  id: ID!
  contactDetails: ContactDetails
  posts: [Post]
  description: String!
}

type ContactDetails {
  id: ID!
  author: Author
  email: String!
}

type Post {
  id: ID!
  text: String!
  author: Author
}
```

We're considering the `createAuthor` and `updateAuthor` mutation to see how to update nested nodes for the *to-one* relation `AuthorContactDetails` and the *to-many* relation `AuthorPosts`.

## Nested Update Mutations for to-one Relations

Let's explore the available nested update mutations for the `one-to-one` relation `AuthorContactDetails`.

#### Creating a new Author node and connect it to existing ContactDetails

```graphql
---
endpoint: https://api.graph.cool/relay/v1/ciz751zxu2nnd01494hr653xl
disabled: true
---
```

Note the nested `contactDetailsId` argument that we pass the id of an existing `ContactDetails` node. After running this mutation, the new author node and the existing contact detail node are connected via the `AuthorContactDetails` relation.

#### Updating an existing Author and connect it to existing ContactDetails

Similarly, we can update an author and simultaneously connect it to existing contact details:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/ciz751zxu2nnd01494hr653xl
disabled: true
---
mutation createAuthorAndConnectContactDetails {
  createAuthor(
    input: {
      description: "I am a good author!"
      contactDetailsId: "ciz7573ffx1w80112cjwjduxn"
      clientMutationId: "abc"
    }
  ) {
    author {
      cont
    }
    contactDetails {
      id
    }
  }
}
---
{
  "data": {
    "createAuthor": {
      "id": "ciz7573ffx1w70112hwj04hqv",
      "contactDetails": {
        "id": "ciz7573ffx1w80112cjwjduxn"
      }
    }
  }
}
```

## Nested Update Mutations for to-many Relations

Let's explore the available nested update mutations for the `one-to-many` relation `AuthorPosts`.

#### Creating a new Author node and connect it to multiple existing Posts

```graphql
---
endpoint: https://api.graph.cool/relay/v1/ciz751zxu2nnd01494hr653xl
disabled: true
---
mutation createAuthorAndConnectPosts($postsIds: [ID!]) {
  createAuthor(
    input: {
      description: "I am a good author!"
      postsIds: $postsIds
      clientMutationId: "abc"
    }
  ) {
    author {
      description
      posts {
        count
      }
    }
  }
}
---
{
  "postsIds": ["ciz787j6eqmf5014929vvo2hp", "ciz787j6eqmf60149lg3jvi4r"]
}
---
{
  "data": {
    "createAuthor": {
      "author": {
        "description": "I am a good author!",
        "posts": {
          "count": 2
        }
      }
    }
  }
}
```

Note the nested `postsIds` list of `Post` ids. After running this mutation, the new author node and the existing post nodes are now connected via the `AuthorPosts` relation.

#### Updating an existing Author and Connecting it to multiple new Posts

Similarly, we can update an author and simultaneously connect it to multiple existing new posts for that author:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/ciz751zxu2nnd01494hr653xl
disabled: true
---
mutation updateAuthorAndConnectPosts($postsIds: [ID!]) {
  updateAuthor(
    input: {
      id: "ciz7573ffx1w70112hwj04hqv"
      description: "I am a good author!"
      postsIds: $postsIds
      clientMutationId: "abc"
    }
  ) {
    author {
      description
      posts {
        count
      }
    }
  }
}
---
{
  "postsIds": ["ciz787j6eqmf5014929vvo2hp", "ciz787j6eqmf60149lg3jvi4r"]
}
---
{
  "data": {
    "createAuthor": {
      "author": {
        "description": "I am a good author!",
        "posts": {
          "count": 2
        }
      }
    }
  }
}
```
