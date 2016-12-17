---
alias: ij2choozae
path: /docs/reference/platform/models
layout: REFERENCE
description: Models define the structure of your data and consist of fields. They can be compared with table schemas in SQL databases.
tags:
  - platform
  - models
  - data-schema
related:
  further:
    - ahwoh2fohj
    - teizeit5se
    - goh5uthoc1
    - uhieg2shio
  more:
    - daisheeb9x
    - ga2ahnee2a
    - aing2chaih
---

# Models

A *model* defines the structure for a certain type of your data. (If you are familiar with SQL databases you can think of a model as the schema for a table.) A model has a name, an optional description and one or multiple [fields](!alias-teizeit5se).

An instantiation of a model is called a *node*. The collection of all nodes is what you would refer to as "your data". The term node refers to a node inside your data graph.

> For example, the users John, Sandra and Paul are three different nodes of the `User` model.

Every model will be available as a type in your GraphQL schema. A common notation to quickly describe a Model is the [GraphQL IDL](https://github.com/facebook/graphql/pull/90) (interface definition language).

> If your application is a blog where people can write posts and comment, you could define three models: `User`, `Post` and `Comment`. The IDL representation could look like this:

```idl
type User {
  id: ID
  name: String
  posts: [Post]
  comments: [Comment]
}

type Post {
  id: ID
  slug: String
  title: String
  text: String
  published: Boolean
  author: User
  comments: [Comment]
}

type Comment {
  id: ID
  text: String
  post: Post
  author: User
}
```

Together with [relations](!alias-ahwoh2fohj), models define your [data schema](!alias-ahwoh2fohj).
