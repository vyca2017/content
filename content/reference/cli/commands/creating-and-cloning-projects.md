---
alias: aetoh3vad6
path: /docs/reference/cli/commands/creating-and-copying-projects
layout: REFERENCE
description: A common workflow the Graphcool CLI is used for is creating and copying projects.
tags:
  - cli
related:
  further:
    - yahph3foch
  more:
---

# Creating and Copying Projects

You can use `graphcool init` to create and copy projects. This will create a new [`project.graphcool` file](!alias-ow2yei7mew) in the current folder.

## General Settings

`graphcool init` provides arguments for general settings of the project to be created.

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

Get more information by running `graphcool init -h`.

### Starting a brand new project

To start a new project, run the wizard with `graphcool init` and you may choose between two options:

* **Quickstart:** This will create a new project that's already set up with an example Instagram schema
* **Blank Project:** Creates a new empty project

> If the current folder already contains a project file, a third option to copy the corresponding project is available.

This creates a new `project.graphcool` file with either an example Instagram schema, or a blank schema.

You can also start a new project based on a [schema file](!alias-aeph6oyeez):

```sh
# create a new project based on a local schema files
graphcool init --schema schema.graphql

# create a new project based on a remote schema file
graphcool init --schema https://graphqlbin.com/instagram.graphql
```

This creates a new `project.graphcool` file based on the passed schema file.

### Copying an existing project

You can use `graphcool init --copy` to create a new project based on an existing one. The parameter `--copy-opts` can be used to specify what should be copied over: nothing, data, mutation-callbacks or both.

```sh
# copy a project with data and mutation callbacks
graphcool init --copy <project-id | alias>

# copy a project with data only
graphcool init --copy <project-id | alias> --copy-opts data
```

This creates a new project and a new `project.graphcool` file based on the schema file.
