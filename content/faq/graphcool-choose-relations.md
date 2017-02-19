---
alias: chietu0ahn
path: /docs/faq/graphcool-choose-relations
layout: FAQ
title: How to choose the correct relation?
description: Learn what relations are and how you can make the correct choice when designing relations as part of your GraphQL schema and data model.
tags:
  - platform
  - relations
  - simple-api
  - relay-api
  - mutations
related:
  further:
    - zeich1raej
    - ofee7eseiy
    - ahwoh2fohj
    - goh5uthoc1
  more:
    - daisheeb9x
    - ahsoow1ool
---

# How to choose the correct relation?

When designing your data model, you can use [relations](!alias-goh5uthoc1) to express interactions between [models](!alias-ij2choozae).

## Relation terminology

Relations can be described using different parameters. Each of them influence your later usage with relations, in both queries and mutations. When creating a new relation, you have to state

* the two related **models** that signify which nodes can potentially be related to each other.
* the two **field names**, one field for each related model. These field names will be reflected in your schema, allowing you to select information on related nodes in queries and mutations.
* the relation **name** that is used to generate the mutation names that allow you to connect or disconnect two nodes as part of this relation.
* the relation **multiplicity**. For a given node on one side of the relation, the multiplicity controls how many nodes on the other side can be related to this node.

Reasonable naming choices depend on the domain of your project. You can get some inspirations from these [examples](#relation-examples).

## Possible Relation Multiplicities

Multiplicities constrain the number of nodes a specific node can be related to: one or many. This applies to both sides of the relation, which results in these possible combinations:

* one-to-one: Nodes on both sides on the relation can only be related to either zero or one node on the other side. In other words, for every node, there must not be two nodes on the other side related to this node.
* one-to-many: Nodes on one side of the relation can only be related to either zero or one node. Nodes on the other side can be related to zero, one or many nodes.
* many-to-many: Nodes on both sides of the relation can be related to zero, one or many nodes on the other side.

When thinking about the correct multiplicity for a given relation, you should consider both sides of the relation. Together with the relation name of the relation, the relation multiplicity affects the names of mutations that are generated for this relation. You can see how these names are constructed in the following examples.

## Relation Examples

When building a blog page, you might come up with this schema:

```idl
type Article {
  id: ID!
  author: User
  comments: [Comment]
  likedByUsers: [User]
  metaInformation: MetaInformation
  text: String!
}

type Comment {
  id: ID!
  article: Article
  author: User
  text: String!
}

type MetaInformation {
  id: ID!
  article: Article
  slug: String!
  tags: [String]!
}

type User {
  id: ID!
  writtenArticles: [Article]
  comments: [Comment]
  likedArticles: [Article]
  name: String!
}
```

Our blog has articles with meta information, comments and users that can write, comment or like articles.
Let's group the relations found in this schema by their multiplicity:

### One-to-one

The only one-to-one relation here is the relation that connects `Article` with `MetaInformation`. It is a one-to-one relation, because we only need one meta information per article, and each meta information should only be related to one article.

Reasonable names for this relation include `ArticleInformation`, `ArticleMetaInformation` or just `MetaInformation`. Let's say we go with `ArticleMetaInformation`, then these would be the available mutations:

* `setArticleMetaInformation(articleArticleId: ID!, metaInformationMetaInformationId: ID!)`
* `unsetArticleMetaInformation(articleArticleId: ID!, metaInformationMetaInformationId: ID!)`

The mutation names start with `set` and `unset` because this is a one-to-one relation. It ends with `ArticleMetaInformation`, because we chose this as our relation name. As for the query arguments, `metaInformation` and `article` are derived from the field names in our schema, while `MetaInformation` and `Article` are derived from the model names. `Id` is appended to signify that the arguments are ids.

Both mutations offer the related nodes `articleArticle` and `metaInformationMetaInformation` in their response.

### One-to-many

We have a few one-to-many relations. Here are possible names for a few:

* `WrittenArticles`, `AuthorWrittenArticles`, `WrittenByUser`, `ArticleAuthor`
* `UserComments`, `AuthorComments`, `Comments`, `CommentAuthor`

Let's further examine the `AuthorComments` relation. It is a one-to-many relation because a user can have multiple comments. However, a comment can only be related to one user.

These mutations are available:

* `addToAuthorComments(commentsCommentId: ID!, authorUserId: ID!)`
* `removeFromAuthorComments(commentsCommentId: ID!, authorUserId: ID!)`

Both mutations offer the related nodes `commentsComment` and `authorUser` in their response.

### Many-to-many

The only many-to-many relation in our schema connects users with articles they like. Because an article can be liked by many users, and a user can like many articles, it is a many-to-many relation.

We could call it `LikedArticles`, `ArticleLikes` or `UserLikedArticles`. Let's go with `LikedArticles`. This results in the following two mutations:

* `addToLikedArticles(likedByUsersUserId: ID!, likedArticlesArticleId: ID!)`
* `removeFromLikedArticles(likedByUsersUserId: ID!, likedArticlesArticleId: ID!)`

Both mutations offer the related nodes `likedByUsersUser` and `likedArticlesArticle` in their response.
