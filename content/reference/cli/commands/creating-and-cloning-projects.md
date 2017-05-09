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

You can use `graphcool init` to create a new project and `graphcool clone` to clone an existing one. This will create a new [`project.graphcool` file](!alias-ow2yei7mew) in the current folder.

## General Settings

`graphcool init` and `graphcool clone` share similar arguments for general settings of the project to be created.

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

* the **name of the new project file** can be controlled with `--output`

Get more information by running `graphcool init -h` or `graphcool clone -h`.

### Starting a brand new project

To start a new project, run the wizard with `graphcool init` and you may choose between two options:

* **Quickstart:** This will create a new project that's already set up with an example Instagram schema
* **Blank Project:** Creates a new empty project

This creates a new `project.graphcool` file with either an example Instagram schema, or a blank schema.

You can also start a new project based on a [schema file](!alias-aeph6oyeez):

```sh
# create a new project based on a local schema files
graphcool init --file schema.graphql

# create a new project based on a remote schema file
graphcool init --url https://graphqlbin.com/instagram.graphql
```

This creates a new `project.graphcool` file based on the passed schema file.

### Cloning an existing project

You can use `graphcool clone` to create a new project based on an existing one:

```sh
graphcool clone
```
