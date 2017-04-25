---
alias: iox3aqu0ee
path: /docs/reference/platform/authorization/permission-queries
layout: REFERENCE
description: GraphQL permission queries leverage the power of GraphQL to define data requirements in a straight-forward way.
tags:
  - platform
  - permissions
related:
  further:
    - xookaexai0
  more:
    - miesho4goo
---

# Permission Queries

Permission queries work by defining a GraphQL query that runs against a specific **GraphQL permission schema**.

* *For read permissions, the permission query is executed and evaluated for every single node*
* *For all other permissions, the permission query is executed and evaulated  before the pending operation*

## The GraphQL Permission Schema

<!-- PERMISSION_EXAMPLES -->

All available queries in the GraphQL permission schema are derived from the available types and relations in your data model. The permisson schema leverages the familiar and powerful [filter system](!alias-xookaexai0) that allows you to define very specific permissions.

For every type `Type` in your data model, the field `someTypeExists(filter: TypeFilter): Boolean` is available in your permission query. `someTypeExists` returns `true` only if the given filters match at least one `Type` node. If all fields in your permission query return `true`, the permission is granted.

Depending on the permission operation, several **GraphQL variables** are available that can be used as input to the different queries.

## Available GraphQL Variables for Permission Queries

### Custom Variables

* `$now: DateTime!` the current time as a [`DateTime`](!alias-teizeit5se#datetime)

### Variables for Type Permissions

* `$node_id: ID!` the id of the current node
* `$node_scalar` the value of a scalar field on an existing node

* `$user_id: ID!` the id of the authenticated user
* `$input_scalar` the value of an input argument of a given mutation

### Variables for Relation Permissions

* `$leftModel_id: ID!`, `$rightModel_id: ID!` the ids of the nodes to be connected or disconnected

## Common Authorization Patterns

Permission queries can be used to express all common authorization patterns like **role-based authorization**, **access control lists** and **ownership derived access**. For more information check [the full guide](!alias-miesho4goo).
