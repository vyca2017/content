---
alias: yahph3foch
path: /docs/reference/console/projects
layout: REFERENCE
description: In the Graphcool console, you can manage multiple GraphQL projects, define your GraphQL schema and create or modify your data set.
tags:
  - console
related:
  further:
  more:
---

# Projects

Apps you are building with Graphcool are organized into different projects. A project consists of a [data schema](), the data itself and other components like [integrations]() or [permission configuration]().

## Project Endpoints

A project offers different [API]() endpoints that all contain the project id.

![](./endpoints.png?width=400)

## Managing projects

By clicking the arrow next to the active project's name, you can expand the project list to get an overview of all your existing projects.

![](./project-list.png?width=200)

Click the plus button to create new projects. The schema of a new project will be populated with the existing [system models]().

Project names can contain **alphanumeric characters and spaces** and need to start with an uppercase letter. They can contain **maximally 64 characters**.

*Project names are unique on an account level.*

#### Examples

* `My Project`
* `MyProject2`
* `MY PROJECT`

More options to manage your project can be found in the [project settings]().
