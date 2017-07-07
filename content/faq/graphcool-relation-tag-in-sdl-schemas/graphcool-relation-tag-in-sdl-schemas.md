---
alias: jor2ohy6uu
path: /docs/faq/graphcool-relation-tag-in-idl-schemas
layout: FAQ
description: A GraphQL Schema Definition is the easiest way to describe an entire GraphQL API. Using the relation tag, you can define GraphQL relations.
tags:
  - graphql
  - data-schema
related:
  further:
    - ahwoh2fohj
    - teizeit5se
    - ij2choozae
  more:
    - moach1gich
    - kr84dktnp0
---

# How can I define relations in an SDL schema file?

With the [SDL (schema definition language)](!alias-kr84dktnp0), it's easy to describe the data model of a GraphQL project. Here's an example schema:

```graphql
type User {
  id: ID!
  name: String!
  comments: [Comment!]! @relation(name: "UserComments")
  posts: [Post!]! @relation(name: "AuthorPosts")
}

type Post {
  id: ID!
  title: String!
  author: User @relation(name: "AuthorPosts")
  comment: Comment @relation(name: "PostComments")
}

type Comment {
  id: ID!
  text: String!
  author: User @relation(name: "UserComments")
  post: Post @relation(name: "PostComments")
}
```

We're defining three types, `User`, `Post` and `Comment`. The scalar fields are of type `ID` or `String`. We are defining three different relations in this schema:

* `UserComments` connects one user with all the comments he posted
* `AuthorPosts` connects one user with all the posts he has written
* `PostComments` connects a post with all comments that have been posted

Note the use of the **`@relation` tag** to define the respective relations.
