---
alias: iegoo0heez
path: /docs/reference/platform/permissions
layout: REFERENCE
description: Permissions are built on top of your GraphQL operations and can be used to authorize data access based on the authenticated user.
tags:
  - platform
  - permissions
  - authentication
related:
  further:
    - uh8shohxie
    - eixu9osueb
  more:
    - pheiph4ooj
    - goij0cooqu
    - noohie9hai
---

# Permissions

Permissions can be used to control data access on your data. A request trying to execute a certain operation is only allowed if a matching permission is defined.

## Model permissions

[Model](!alias-ij2choozae) permission are described by an [operation](#operation), a [permission level](#permission-level) and a set of [fields](!alias-teizeit5se) of the given model.

Whenever someone is requesting to read or modify a field of a model, all available permissions will be checked against the request.
The operation will only be executed if there is at least one permission for every field in question whose parameters match the request.
Otherwise the request will result in a permission error that will be returned as the query response.

### Permission fields

A model permission is associated with a list of fields of the given model. You can include as few as one and as much as all available fields in the permission.

### Operation

Every model permission is associated with exactly one operation that can be one of the following.

* Read
* Create
* Update
* Delete

### Permission Level

A permission level describes the required minimum access level the [session user](!alias-wejileech9#session-user) needs to successfully perform a certain operation:

* A user that is not authenticated is granted `EVERYONE` level access.
* An authenticated user is additionally granted `AUTHENTICATED` level access.

The permission level is determined based on the [session user](!alias-wejileech9#session-user) token in the request header.

## Query permissions

> Note: this feature will roll out in the future.

A query based permission is additionally associated with an arbitrary query that has access to certain predefined query parameters.
The query associated with a query based permission will be executed when an according request comes in and the request will only be granted permission if the response to that query contains at least one leaf-node with a non-null field.

## Permissions and user authentication

If you want to make use of the built-in user authentication system, you should make sure to setup your permissions so that `EVERYONE` can call the `createUser` and `signinUser` mutation.
Otherwise, users can neither sign up or login to access your project data from within your application. To read more about user authentication, head over to the [Simple API](!alias-eixu9osueb) or the [Relay API](!alias-yoh9thaip0).
