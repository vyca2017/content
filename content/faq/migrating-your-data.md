---
alias: he6jaicha8
path: /docs/faq/migrate-your-data
layout: FAQ
title: How to migrate my data after schema changes?
description: When working with fields in your GraphQL schema, you might have to migrate existing data. More complex scenarios can be handled by a script.
tags:
  - platform
  - data-management
  - data-schema
  - fields
  - relations
  - migrations
related:
  further:
    - ahwoh2fohj
    - ij2choozae
    - teizeit5se
    - kie1quohli
  more:
    - ga2ahnee2a
    - taith2va1l
    - aing2chaih
    - ih4etheigo
    - uu2xighaef
---

# How to migrate data after a schema changes?

## Migrating fields

When working with [fields](!alias-teizeit5se), you might be prompted to set a *migration value*.

A migration value is a field value which is applied to existing nodes. In case a [model](!alias-ij2choozae) doesn't have any nodes yet, you do not have to provide a migration value.

Migration values are not the same as [default values](!alias-teizeit5se#default-value) and just exist temporarily in one of the following scenarios:

You have to provide a migration value when you
* create a new [required field](!alias-teizeit5se#required).
* mark an existing non-required field as [required](!alias-teizeit5se#required).
* change the [type](!alias-teizeit5se#scalar-types) of a field.

You can provide a migration value when you create a new non-required field, but you don't have to.

## Complex migrations

If your specific migration task is not covered by the automatic options above, you can perform the [migration using a custom script](!alias-uu2xighaef).
