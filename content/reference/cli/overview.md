---
alias: kie1quohli
path: /docs/reference/cli/overview
layout: REFERENCE
description: The Graphcool CLI
beta: true
tags:
  - cli
  - data-schema
  - data-management
  - migrations
related:
  further:
    - chohbah0eo
    - he6jaicha8
  more:
    - kr84dktnp0
---

# CLI

With the CLI you can manage changes to a project's schema and data. You can install it with npm:

```sh
npm install -g graphcool
```

> Note: the CLI is under active development and will be released in the future

## Creating a new Project

> Create a new project (uses graphcool.schema in [IDL Schema definition syntax](!alias-kr84dktnp0) as template if exists).

```sh
graphcool create --name 'My Project' --alias 'my-project' --region 'us-west-1'
```

## Updating the Schema of a Project

> Apply local config changes to a project.

```sh
graphcool update --config 'graphcool.schema' --dry-run
```

## Fetch Latest Config for a Project

```sh
graphcool fetch --project-id 'my-project'
```
