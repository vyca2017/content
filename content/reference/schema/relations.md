---
alias: goh5uthoc1
path: /docs/reference/schema/relations
layout: REFERENCE
description: A relation defines the interaction between two types. Related types are reflected in both the data model as well as the GraphQL schema.
tags:
  - platform
  - relations
related:
  further:
    - ahwoh2fohj
    - ij2choozae
    - teizeit5se
    - uhieg2shio
    - oe3raifamo
  more:
    - daisheeb9x
    - aing2chaih
    - ahsoow1ool
---

# Relations

A *relation* defines the interaction between two [types](!alias-ij2choozae). Two types in a relation are connected via a [relation field](!alias-teizeit5se) on each type.

> Note: A type can be related to itself.

## Relation parameters

## Multiplicity

Both sides of a relation can have two different multiplicities, singular and plural, or more typically called one and many.

### One-to-one

> `PostMetadata` could be a one-to-one relation relating the `Post` type to the `Metadata` type. Starting from a `Post` node you can access the related `Metadata` node via the `metadata` field. The related post is exposed on nodes of the `Metadata` type using the `post` field.

### One-to-many

> `PostAuthor` could be a one-to-many relation relating the `User` type to the `Post` type, because one author can write multiple posts while a post can only have one author. Starting from a `User` node you can access the related `Post` nodes via the `posts` field. The author is exposed on nodes of the Post type using the `author` field.


### Many-to-many

> If a book can have multiple authors, `BookAuthors` could be a many-to-many relation between the `Book` and `User` types, because one author can write many books, while one book also can be written by multiple authors.

## Relations in the Data Schema

A relation is defined in the Data Schema using the [@relation directive](!alias-aeph6oyeez#relation-fields):

```graphql
type User {
  id: ID!
  stories: [Story!]! @relation(name: "UserOnStory")
}

type Story {
  id: ID!
  text: String!
  author: User! @relation(name: "UserOnStory")
}
```

Here we are defining a *one-to-many* relation between the `User` and `Story` types. The relation fields are `stores: [Story!]!` and `author: User!`. Note how `[Story!]!` defines multiple stories and `User!` a single user.

## Generated Operations Based On Relations

The names of the relation and fields will define how [generated queries](!alias-nia9nushae) and [mutations](!alias-ol0yuoz6go) look like.
