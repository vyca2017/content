---
alias: goh5uthoc1
path: /docs/reference/schema/relations
layout: REFERENCE
description: A relation defines the interaction between two models. Related models are reflected in both the data model as well as the GraphQL schema.
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

A *relation* defines the interaction between two [models](!alias-ij2choozae). Related models are reflected in both the data model as well as the GraphQL schema.

If two models are related to each other via a relation, each of them gets a new [field](!alias-teizeit5se). The names of the relation and fields will define how [generated queries](!alias-nia9nushae) and [mutations](!alias-ol0yuoz6go) look like.

Note: A model can be related to itself.

Note: Relations are symmetrical in such a way that it makes no difference which sides of the relation you assign to the two related models.

## Multiplicity

Both sides of a relation can have two different multiplicities, singular and plural, or more typically called one and many.

### One-to-one

> `PostMetadata` could be a one-to-one relation relating the `Post` model to the `Metadata` model. Starting from a `Post` node you can access the related `Metadata` node via the `metadata` field. The related post is exposed on nodes of the `Metadata` model using the `post` field.

### One-to-many

> `PostAuthor` could be a one-to-many relation relating the `User` model to the `Post` model, because one author can write multiple posts while a post can only have one author. Starting from a `User` node you can access the related `Post` nodes via the `posts` field. The author is exposed on nodes of the Post model using the `author` field.


### Many-to-many

> If a book can have multiple authors, `BookAuthors` could be a many-to-many relation between the `Book` and `User` model, because one author can write many books, while one book also can be written by multiple authors.

## Connection & Edges

A relation can only exist between two [models](!alias-ij2choozae). Two nodes that are related to each other are connected by an *edge*. All edges belonging to the same relation form a *connection*.

Note: Two nodes can only be connected once for each relation between the according two models.
