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

## export

```sh
# export data as JSON (use if only one *.graphcool file in folder)
graphcool export

# export data as JSON for specified project file
graphcool export --project project.graphcool
```

## endpoints

```sh
# print API endpoints for current project
graphcool endpoints
```

## console and playground

```sh
# open Console for current project in browser
graphcool console

# open Playground for current project in browser
graphcool playground
```

## projects

```sh
# list all project names and ids of the authenticated user
graphcool projects
```

## auth

```sh
# opens browser and authenticates CLI as the user that's currently logged into the Console
graphcool auth
```

## version

```sh
# print version of the installed graphcool CLI
graphcool version
```
