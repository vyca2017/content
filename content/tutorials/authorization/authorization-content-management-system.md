---
alias: miesho4goo
path: /docs/tutorials/authorization-content-management-system
layout: TUTORIAL
description: Learn how to build secure authorization in GraphQL by defining role-based, owner-based and relation-based permissions powered by flexible filters.
tags:
  - permissions
  - authorization
  - platform
  - console
related:
  further:
    - iegoo0heez
  more:
    - pheiph4ooj
---

# Authorization for a CMS with GraphQL Permission Queries

Security is one of the most critical parts of an application. Combining authentication methods with authorization rules empowers developers to build secure apps in a straight-forward way.

This article is a case study that gives an idea how to combine **role-based**, **owner-based** and **relation-based** permissions to secure access when building a *content management system*.

Let's consider the following GraphQL schema in [IDL syntax](!alias-kr84dktnp0):

```graphql
type User {
  id: ID
  name: String!
  role: UserRole!
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroupMembers")
  documents: [Document!]! @relation(name: "DocumentOwner")
}

type Document {
  id: ID
  content: String!
  published: Boolean!
  title: String!
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroupDocuments")
  owner: [User!]! @relation(name: "DocumentOwner")
}

type AccessGroup {
  id: ID
  operation: AccessGroupOperation!
  members: [User!]! @relation(name: "AccessGroupMembers")
  documents: [Document!]! @relation(name: "AccessGroupDocuments")
}

enum UserRole {
  EDITOR,
  MODERATOR,
  ADMIN
}

enum AccessGroupOperation {
  READ,
  UPDATE,
  DELETE
}
```

## How Permission Queries Work

#### Whitelist Permissions for Modular Authorization

Permission queries work by defining a GraphQL query that runs against a specific **GraphQL permission schema**. They return a boolean and the permission is only granted if it resolves to `true`. In general, permissions follow a **whitelist approach**:

* *no operation is permitted unless explicitely allowed*
* *a permission cannot be nullified by other permissions*

This means that as soon as a matching permission has been found for a given request, it can be executed which allows us to think about authorization in a modular way. Focusing on a specific use case when defining a permission rule leads to many simple permissions instead of fewer complex ones.

#### Permission Parameters and GraphQL Variables

Permissions are described using different **parameters**.

* The **operation** of a permission describes what types of requests it is evaluated for. There are operations related to a *type* and those related to a  *relation*. While the available CRUD operations are covered by type operations, connecting or disconnecting nodes for a relation are governed by relation operations.

> Note: [nested mutations], are broken down into multiple isolated operations. A nested mutation might need to pass a `Create Type` and multiple `Update Relation` permissions for instance.

* For most type operations, it's of interest which **fields** the permission governs while relation permissions can affect connecting, disconnecting or both operations.

* The **audience** of a permission describes how the permission relates to the authenticated state of a request. A permission can either be open to `EVERYONE` or only to `AUTHENTICATED` users.

Depending on the permission operation, different GraphQL variables are available that can be used to express the permission. The [reference documentation](#TODO) gives a full overview.

## Authorization Design Patterns

Before diving into the different **authorization design patterns**, let's start this off with a simple example to get used to the different terms:

### View Node: everyone can see published documents

> Everyone can query published documents.

```graphql
query permitViewDocuments($node_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    published: true
  })
}
```
Note how the `$node_id` variable is used in combination with the `filter` argument to check if the *queried node is published*. If this is the case, `someDocumentExists` returns `true`, and the operation is granted permission.

#### Permission parameters

* **Operation:** `View Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `EVERYONE`

There are three broad categories of commonly used permission types that enable extremely powerful authorization rules when combined. Let's have a closer look!

## User Roles for Broad Authorization Rules

In our schema, we can assign different roles to users via the *enum field `role` on the `User` model* with the possible values `EDITOR`, `MODERATOR` and `ADMIN`. This paves the way for **role-based permissions**, which are very useful if different kinds of users should have different access levels.

### View Node: admins can view unpublished documents

This is our first *role-based* permission:

> Users with the role `ADMIN` can query all documents.

```graphql
query permitViewDocuments($node_id: ID!, $user_id: ID!) {
  someUserExists(filter: {
    id: $user_id
    role: ADMIN
  })
}
```

In this case, we use the `someUserExists` to check if the session user has the `ADMIN` role using the `$user_id` variable. We don't use `someDocumentExists`, it's irrelevant for `ADMIN` users.

#### Permission parameters

* **Operation:** `View Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Create Node: editors can only assign themselves as the document owner

Whenever our schema contains relations that express ownership, we need to make sure that users don't maliciously assign a wrong owner. This is a combination of a `role-based` and `owner-based` rule.

> Users of type `EDITOR`s can only assign themselves as the document owner.

```graphql
query permitCreateDocuments($user_id: ID!, $input_ownerId: ID!) {
  someUserExists(filter: {
    AND: [{
      id: $user_id
    }, {
      id: $input_ownerId
    }]
  })
}
```

Because we want to express two conditions on the `id` variable, we need to use the logical operator `AND`. Then we check that the two variables `$user_id` (the logged-in user) and `$input_ownerId` (the id that identifies the owner-to-be of the document).

#### Permission parameters

* **Operation:** `Create Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Create Node: moderators and admins can assign anyone as the document owner

This is another `role-based` rule.

> Users of type `ADMIN` or `MODERATOR` can assign anyone as the document owner.

```graphql
query permitCreateDocuments($user_id: ID!) {
  someUserExists(filter: {
    id: $user_id
    role_in: [ADMIN, MODERATOR]
  })
}
```

#### Permission parameters

* **Operation:** `Create Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Update Node: moderators can publish or unpublish a document

This is a `role-based` permission that only acts on a subset of the available fields. In this case, we only express a permission about the `published` field.

> Users of type `ADMIN` or `MODERATOR` can publish or unpublish a document

```graphql
query permitUpdateDocuments($user_id: ID!) {
  someUserExists(filter: {
    id: $node_id
    role_in: [ADMIN, MODERATOR]
  })
}
```

#### Permission parameters

* **Operation:** `Create Document`
* **Fields:** `published`
* **Audience:** `AUTHENTICATED`

### Delete Node: admins can delete documents

Another *role-based* permission:

> Users of type `ADMIN` can delete documents.

```graphql
query permitDeleteDocuments($user_id: ID!) {
  someUserExists(filter: {
    id: $user_id
    role: ADMIN
  })
}
```

#### Permission parameters

* **Operation:** `Delete Document`
* **Fields:** *no fields need to be selected for delete permissions*
* **Audience:** `AUTHENTICATED`

## Access Control Lists based on Relations

Finally, the `AccessGroup` model acts as way to express **relation-based** permissions. These are similar to *owner-based* permissions, but allow much more flexibility. The `accessLevel` enum field with possible values `READ`, `UPDATE` and `DELETE` can be used to define **access control lists or ACLs**.

### View Node: users with read access for a specific document

This is our first *relation-based* rule:

> Users connected to a document via an access group with `READ` access can view a document.

```graphql
query permitViewDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    accessGroups_some: {
      accessLevel: READ
      members_some: {
        id: $user_id
      }
    }
  })
}
```

Here we use relational filters, starting with the `someDocumentExists` query, to check if the document to be viewed (identified by `$node_id`) is connected to an access group with `READ` access that the session user (identified by `$user_id`) is connected to as well. Note that we can also turn it around, starting with `someUserExists`:

```graphql
query permitViewDocuments($node_id: ID!, $user_id: ID!) {
  someUserExists(filter: {
    id: $user_id
    accessGroups_some: {
      accessLevel: READ
      documents_some: {
        id: $node_id
      }
    }
  })
}
```

#### Permission parameters

* **Operation:** `View Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Update Node: users with the update access level can edit a specific document

Another *relation-based* rule:

> Users connected to a document via an access group with `UPDATE` access can update a document.

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

#### Permission parameters

* **Operation:** `Update Document`
* **Fields:** `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Delete Node: users with the delete access level can delete a specific document

Another *relation-based* permission:

> Users connected to a document via an access group with `DELETE` access can delete a document.

```graphql
query permitDeleteDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    accessGroups_some: {
      accessLevel: DELETE
      members_some: {
        id: $user_id
      }
    }
  })
}
```

#### Permission parameters

* **Operation:** `Delete Document`
* **Fields:** *no fields need to be selected for delete permissions*
* **Audience:** `AUTHENTICATED`

## Elevated Access for Owners

Additionally, the relation `DocumentOwner` acts as the basis for **owner-based** permissions. Usually, we want to allow the owner of a node access to special operations, like deleting or publishing an owned document.

### View Node: owners can view unpublished documents

This is our first *owner-based* rule:

> A user can query the documents he owns, even unpublished ones.

```graphql
query permitViewDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    owner: {
      id: $user_id
    }
  })
}
```

Here, we use the `someDocumentExists` query and combine it with the `$node_id` and `$user_id` variables to ensure that the current node to be queried is owned by the logged-in user.

### Update Node: the owner of an document can edit it

This is another `owner-based` permission rule.

> Users can edit their own documents.

```graphql
query permitUpdateDocuments($node_id: ID!, $user_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    owner: {
      id: $user_id
    }
  })
}
```

#### Permission parameters

* **Operation:** `Update Document`
* **Fields:** `content`, `published`, `title`
* **Audience:** `AUTHENTICATED`

### Delete Node: the owner of a document can delete it

This is another `owner-based` permission:

> Users can delete document they own.

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

#### Permission parameters

* **Operation:** `Delete Document`
* **Fields:** *no fields need to be selected for delete permissions*
* **Audience:** `AUTHENTICATED`
