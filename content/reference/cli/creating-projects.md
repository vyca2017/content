---
alias: aetoh3vad6
path: /docs/reference/cli/commands/creating-and-cloning-projects
layout: REFERENCE
description: The Graphcool CLI lets you work with the schema of a project. You can easily create a new project or update the schema of an existing one.
tags:
  - cli
related:
  further:
  more:
---

# Creating and Cloning Projects

To create a new project, you can use `graphcool init`. This will create a new [project configuration file](!alias-ow2yei7mew) in the current folder.

See also the full reference of the `graphcool init` command.

## General Settings

* the **name of the new project** can be controlled with `--name`

  ```sh
  graphcool init --name 'My new Project'
  ```

* the **project alias** can be controlled with `--alias`

  ```sh
  graphcool init --alias 'my-new-project'
  ```

* the **project region** can be controlled with `--region`

  ```sh
  graphcool init --region 'eu-west-1'
  ```

## Quickstart and Starting From Scratch

To get started quickly and explore how things work, just run `graphcool init` and choose the *quickstart* option. This will set you up with an example Instagram schema. You can also choose to create a blank project to *start from scratch*.

## Creating a New Project Based on a Schema File

[Schema files](!alias-aeph6oyeez) can be used to create a new project.

```sh
# use `init --file` for local schema files
graphcool init --file schema.graphql
```

```sh
# use `init --url` for remote schema files
graphcool init --url https://graphqlbin.com/instagram.graphql
```

## Creating a New Project Based on an Existing Project

Get an overview of your existing projects:

```sh
graphcool projects
```

Copy the project id of the project to be cloned and run:

```sh
graphcool pull --source <project-id>
```
