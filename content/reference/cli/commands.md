---
alias: tha5feef7i
path: /docs/reference/cli/commands
layout: REFERENCE
description: The Graphcool CLI lets you work with the schema of a project. You can easily create a new project or update the schema of an existing one.
tags:
  - cli
related:
  further:
    - chohbah0eo
    - he6jaicha8
  more:
    - kr84dktnp0
---

# Commands Overview

## init

```sh
Usage: graphcool init [options]

 Create a new project from scratch or based on an existing GraphQL schema.

 Options:
   -u, --url <schema-url>    URL to a GraphQL schema
   -f, --file <schema-file>  Local GraphQL schema file
   -n, --name <name>         Project name
   -a, --alias <alias>       Project alias
   -o, --output <path>       Path to output project file (default: project.graphcool)
   -r, --region <region>     AWS Region (default: us-west-2)
   -h, --help                Output usage information

 Note: This command will create a project.graphcool project file in the current directory.
```

## push

```sh
Usage: graphcool push [options]

Push project file changes

Options:
  -d, --dry-run      Simulate command
  -p, --project      Project file (default: project.graphcool)
  -h, --help         Output usage information
```

## pull

```sh
Usage: graphcool pull [options]

Pull the latest project file from Graphcool

Options:
  -s, --source       ID or alias of source project (defaults to ID or alias from project file)
  -p, --project      Project file (default: project.graphcool)
  -o, --output       Path to output project file (default: project.graphcool)
  -h, --help         Output usage information
```

## export

```sh
Usage: graphcool export [options]

Export project data

Options:

  -p, --project      Project file (default: project.graphcool)
  -h, --help         Output usage information
```

## endpoints

```sh
Usage: graphcool endpoints [options]

Export project data

Options:

  -p, --project      Project file (default: project.graphcool)
  -h, --help         Output usage information
```

## console

```sh
Usage: graphcool console [options]

Open current project in Graphcool Console with your browser

Options:
  -p, --project      Project file (default: project.graphcool)
  -h, --help         Output usage information
```

## playground

```sh
Usage: graphcool console [options]

Open current project in Graphcool Playground with your browser

Options:
  -p, --project      Project file (default: project.graphcool)
  -h, --help         Output usage information
```

## projects

```sh
Usage: graphcool projects [options]

List projects

Options:
  -h, --help         Output usage information
```

## auth

```sh
Usage: graphcool auth [options]

Sign up or login (opens your browser for authentication)

Options:
  -t, --token <token>    System token
  -h, --help             Output usage information

Note: Your session token will be store at ~/.graphcool
```

## version

```sh
Usage: graphcool version [options]

Print version

Options:
  -h, --help         Output usage information
```
