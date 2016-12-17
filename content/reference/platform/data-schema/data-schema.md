---
alias: ahwoh2fohj
path: /docs/reference/platform/data-schema
layout: REFERENCE
description: The data schema of a project is defined with models, fields and relations that will define the GraphQL schema of your GraphQL backend.
tags:
  - platform
  - data-schema
related:
  further:
    - ij2choozae
    - teizeit5se
    - goh5uthoc1
    - uhieg2shio
  more:
    - ga2ahnee2a
    - aing2chaih
    - ahsoow1ool
    - he6jaicha8
---

# Data Schema

Every project has its own *data schema*. You can organize your data in [models](#models) and define [relations](#relations) between them.

> For example, if you are running a blog, you need to organize `User`s and `Post`s. A user should be able to be associated with all the posts that he writes. However, a post should only be associated with its single author.
You can transfer this situation by using the `User` and `Post` models and define a relation between them.

## Models

[Models](!alias-ij2choozae) define the structure for a certain type of your data and consist of different fields.

## Fields

[Fields](!alias-teizeit5se) are used to define a model and can have several properties like a type and a default value.

## Relations

[Relations](!alias-goh5uthoc1) can be used to define the relationship between two models.

## System Artifacts

In your Graphcool projects you will encounter certain models and fields that are automatically created. They are referred to as [system artifacts](!alias-uhieg2shio) and cannot be removed from your project.
