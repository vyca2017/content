---
alias: paesahku9t
path: /docs/reference/migrations/overview
layout: REFERENCE
description: There are many possible options to update a GraphQL schema, referred to as schema migrations. Some of them require data migrations as well.
tags:
  - migrations
related:
  further:
  more:
---

# Migrations

Schema migrations covers all changes you can make to your [data schema](). This includes adding or modifying [types](), [fields]() and [relations](). Changes to your schema will be reflected in both the [schema file]() as well as the [project file]() and affect the operations in your [API]().

You can either use the [Console]() or the [CLI]() to execute schema migrations, but we'll use the GraphQL schema to describe possible schema migrations in the following sections.

## Schema Migrations in the Console

The [Console]() provides two ways to update the schema. You can either use the **schema editor** to quickly iterate with schema changes. Or you create or modify the different elements using the UI.

## Schema Migrations with the CLI

The [CLI]() leverages the [project file]() and allows you to synchronize schema changes across your local environment and the Console.
