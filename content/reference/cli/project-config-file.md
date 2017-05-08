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

The project configuration contains the [GraphQL schema](!alias-ahwoh2fohj) of the project as well as additional metadata such as the **project endpoint** and the **version number** of the schema.

Every change to the project schema done by using the Console or the CLI will increment the schema version.

## Synchronize Changes

The project configuration file is used to synchronize changes to general project settings as well as the data schema between the Console and local changes.

### Update Local Project Config

To pull the latest changes from your project and update your local config file, you can use `graphcool pull`.
More information can be found in the command reference.

### Push Local Changes

You can push changes made to your local project configuration file using `graphcool push`. Typically, those are changes to the [schema file](!alias-aeph6oyeez), resulting in [schema migrations]().
More information can be found in the command reference.
