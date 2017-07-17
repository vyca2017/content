---
alias: gechieb9ae
path: /docs/reference/cli/synchronizing-changes
layout: REFERENCE
description: Changes to the project file can be two-way synchronized between your local representation and the remote state.
tags:
  - cli
related:
  further:
    - paesahku9t
  more:
---

# Synchronizing Changes to Project Files

When making changes to the schema from both the Console and the CLI, your local and remote project files might get out of sync. Especially when working in a team this can occur. The CLI offers different commands to get an overview of the current status and to pull or push the latest changes.

## Initial pull

If you are just getting started to work on an existing project with the CLI, you need to do an initial pull operation.

First, copy the id of the project you want to work on using `graphcool projects`:

```sh
# list all project ids
graphcool projects
```

Then use `graphcool pull --project` to pull the latest version of the project file for that project:

```sh
# obtain a project file for a specific project
graphcool pull --project <project-id>
```

## Status overview

If you want to check the current status of your project, the command `graphcool status` is very useful. If there are pending local changes, all resulting operations will be listed here.

## Update existing project file with remote changes

If you already have a project file, you can also simply run `graphcool pull` to update it with the latest remote changes:

```sh
# update existing project file
graphcool pull project.graphcool

# store remote project file in a new local file
graphcool pull --output project-copy.graphcool project.graphcool
```

You can use `--output` to not overwrite your local project file. This is useful to compare the old and new project files with additional tools like `diff`, for example.

## Push local changes to your project

If you made changes to your project file, you can push them with `graphcool push`:

```sh
# apply local changes also remotely
graphcool push project.graphcool
```

This will likely result in changes to the [schema file](!alias-ahwoh2fohj) and will also increment the version number of your project file. This is a common way to do [schema migrations](!alias-paesahku9t).

If you are about to push changes that would result in data-loss, you receive a warning and the operation is aborted. If you are certain you want to update the schema with your local version, you can supply the `--force` argument:

```sh
# apply local changes also remotely resulting in potential data loss
graphcool push --force project.graphcool
```
