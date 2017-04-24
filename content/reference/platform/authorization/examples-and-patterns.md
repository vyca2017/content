---
alias: zievoo3oht
path: /docs/reference/platform/permissions/examples-and-patterns
layout: REFERENCE
description: Several permission queries, following the authorization patterns of role-based authorization, access control lists and ownership derived access.
tags:
  - platform
  - permissions
  - authentication
related:
  further:
    - xookaexai0
  more:
    - miesho4goo
---

# Examples and Patterns for Permission Queries

Here are some examples for permission queries, following the common authorization patterns of **role-based authorization**, **access control lists** and **ownership derived access**.

For more examples check [the full guide](!alias-miesho4goo).

## Role-based Authorization

> Admins can view documents

```graphql
query permitViewDocuments($node_id: ID!, $user_id: ID!) {
  someUserExists(filter: {
    id: $user_id
    role: ADMIN
  })
}
```

## Access Control Lists with GraphQL

> Members of an access group with edit access can update documents

```graphql
query permitUpdateDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    accessGroups_some: {
      accessLevel: UPDATE
      members_some: {
        id: $user_id
      }
    }
  })
}
```

## Ownership Derived Access

> The owner of a document can delete it

```graphql
query permitDeleteDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    owner: {
      id: $user_id
    }
  })
}
```
