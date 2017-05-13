---
alias: ou3ucheewu
path: /docs/reference/console/permissions-view
layout: REFERENCE
description: In the Graphcool console, you can manage multiple GraphQL projects, define your GraphQL schema and create or modify your data set.
tags:
  - console
related:
  further:
  more:
---

# Permissions View

The **Permission View** gives you access to all the defined [permissions]() for your project and allows you to create and modify them.

## Permission list

All existing permissions are listed in the Permission View. They are grouped into **type and relation permissions**.

### Type permissions

Type permissions are associated to a specific [type]() in your project. The permission list contains various information for each type permission:

* whether the permission is applicable to **everyone or only authenticated users**
* the CRUD operation the permission is associated with - this can be either a [query]() or a [create, delete or update. mutation]().
* the **fields the permission is applicable to**.

### Relations permissions

A relation permission is associated to a [relation]() in your project and can be applicable to **connecting or disconnecting operations for that relation, or both**.

> More information can be found in the [permissions]() chapter.
