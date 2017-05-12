---
alias: iegoo0heez
path: /docs/reference/platform/authorization/overview
layout: REFERENCE
description: Graphcool features a simple yet powerful permission system that integrates seamlessly with the available authentication providers.
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
    - miesho4goo
---

# Authorization

Graphcool features a simple yet powerful permission system that integrates seamlessly with the available authentication providers. It combines different concepts that are described in detail below.

> Note: for a better getting started experience, every new Graphcool project is prepopulated with permissions that allow all operations. **Make sure to adjust the permissions before your app goes to production**.

## Whitelist Permissions for Modular Authorization

In general, permissions follow a **whitelist approach**:

* *no operation is permitted unless explicitely allowed*
* *a permission cannot be nullified by other permissions*

Essentially this means that a request is only executed if and only if it *matches* at least one specified permission. This allows us to specify permissions in a modular way and to focus on a specific use case in a single permission which leads to many simple permissions instead of fewer complex ones.

When does a permission match a request? This is determined by the **permission parameters**.

## Permission Parameters

Permissions are described using different **parameters**.

* The **operation** of a permission describes what types of requests it is evaluated for. CRUD operations as derived from a *type* as well as operations for *relations* are available:
  * *type operations* are `Read nodes`, `Create nodes`, `Update nodes`, `Delete nodes`
  * *relation operations* are `Connect nodes` and `Disconnect nodes`

> Note: [nested mutations](!alias-ubohch8quo), are broken down into multiple isolated operations. A nested mutation might need to pass a `Create Type` and multiple `Update Relation` permissions for instance.

* For most type operations, it's of interest which **fields** the permission governs while relation permissions can affect connecting, disconnecting or both operations.

> Note: to apply a permission to future fields as well, choose `apply to whole type` when creating a permission.

* The **audience** of a permission describes how the permission relates to the authenticated state of a request. A permission can either be open to `EVERYONE` or only to `AUTHENTICATED` users.

Permissions described with the above parameters are referred to as *simple permissions*. Additionally, you can define custom permissions using [permission queries](!alias-iox3aqu0ee).

## Permissions and user authentication

If you want to make use of the built-in user authentication system, you should make sure to setup your permissions so that `EVERYONE` can call the `createUser` and `signinUser` mutation.
Otherwise, users can neither sign up or login to access your project data from within your application. To read more about user authentication, head over to the [Simple API](!alias-eixu9osueb) or the [Relay API](!alias-yoh9thaip0).
