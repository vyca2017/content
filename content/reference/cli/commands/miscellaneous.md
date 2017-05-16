---
alias: air0eiph9p
path: /docs/reference/cli/commands/miscellaneous
layout: REFERENCE
description: The Graphcool CLI lets you work with the schema of a project. You can easily create a new project or update the schema of an existing one.
tags:
  - cli
related:
  further:
  more:
---

# Miscellaneous Commands

## General Commands

## status

```sh
# prints general information about the status of your local environment
graphcool status
```

## projects

```sh
# list all project names and ids of the authenticated user
graphcool projects
```

## auth

Typically, it's not needed to run this command directly. If you run a command that requires authentication, such as `graphcool init` you will be automatically prompted to authenticate in your browser.

```sh
# opens browser and authenticates as the logged in Console user
graphcool auth
```

> Note: Your session token is stored at ~/.graphcool

## version

```sh
# print version of the installed graphcool CLI
graphcool version
```

## Project specific commands

Those commands need to be run in a folder that contains a `*.graphcool` file. If there are multiple `*.graphcool` files, you need to specify one of them using the `--project` argument.

## export

```sh
# export data as JSON for the current project
graphcool export

# export data as JSON for specified project file
graphcool export project.graphcool
```

## endpoints

```sh
# print API endpoints for current project
graphcool endpoints

# print API endpoints for current project
graphcool endpoints project.graphcool
```

## console and playground

```sh
# open Console for current project in browser
graphcool console

# open Playground for current project in browser
graphcool playground
```
