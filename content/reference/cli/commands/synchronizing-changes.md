---
alias: gechieb9ae
path: /docs/reference/cli/synchronizing-changes
layout: REFERENCE
description: The Graphcool CLI lets you work with the schema of a project. You can easily create a new project or update the schema of an existing one.
tags:
  - cli
related:
  further:
  more:
---

# Synchronizing Changes to Project Files

## Initial pull

If you are just getting started to work on an existing project with the CLI, you need to do an initial pull operation.

First, copy the id of the project you want to work on using `graphcool projects`:

```sh
# list all project ids
graphcool projects
```

Then use `graphcool pull --source` to pull the latest version of the project file for that project:

```sh
# obtain a project file for a specific project
graphcool pull --source <project-id>
```

## Update existing project file with remote changes

If you already have a project file, you can also simply run `graphcool pull` to update it with the latest remote changes:

```sh
# update existing project file
graphcool pull

# store remote project file in a new local file
graphcool pull --output project-copy.graphcool
```

You can use `--output` to compare the old and new project files with additional tools like `diff`.

## Push local changes to your project

If you made changes to your project file, you can push them with `graphcool push`:

```sh
# apply local changes also remotely
graphcool push
```

This will likely result in changes to the [schema file](!alias-ahwoh2fohj) and will also increment the version number of your project file. This is a common way to do [schema migrations]().

The `--dry-run` option is useful to see what changes would be applied without actually executing them:

```sh
# only simulate the changes
graphcool push --dry-run
```
