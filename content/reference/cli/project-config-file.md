---
alias: ow2yei7mew
path: /docs/reference/cli/project-configuration-files
layout: REFERENCE
description: The Graphcool CLI lets you work with the schema of a project. You can easily create a new project or update the schema of an existing one.
tags:
  - cli
related:
  further:
  more:
---

# Project Configuration Files

Working with **project configuration files** is a central part of using the Graphcool CLI.

Project configuration files are typically saved as `.graphcool` and contain the project's GraphQL schema as well as additional data like the project endpoint.

This is an example project configuration file, `project.graphcool`:

```graphql
# project: cj2deyxfmpmwi0104pce2xucz
# version: 3

type Tweet {
  createdAt: DateTime!
  id: ID! @isUnique
  owner: User! @relation(name: "UserOnTweet")
  text: String!
  updatedAt: DateTime!
}

type User {
  createdAt: DateTime!
  id: ID! @isUnique
  updatedAt: DateTime!
  name: String!
  tweets: [Tweet!]! @relation(name: "UserOnTweet")
}
```

The project configuration contains the [GraphQL schema](!alias-) of the project as well as additional metadata such as the **project endpoint** and the **version number** of the schema.

Every change to the project schema done by using the Console or the CLI will increment the schema version.
