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
  role: USER_ROLE!
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroupMembers")
  documents: [Document!]! @relation(name: "DocumentOwner")
}

type Document {
  id: ID
  content: String!
  published: Boolean!
  title: String!
  accessGroups: [AccessGroup!]! @relation(name: "AccessGroupDocuments")
  owner: [Document!]! @relation(name: "DocumentOwner")
}

type AccessGroup {
  id: ID
  operation: ACCESS_GROUP_OPERATION!
  members: [User!]! @relation(name: "AccessGroupMembers")
  documents: [Document!]! @relation(name: "AccessGroupDocuments")
}
```

## Authorization Patterns in GraphQL

There are three broad categories of permissions types that enable extremely powerful authorization rules when combined. Let's have a closer look!

#### User Roles for Broad Authorization Rules

In our schema, we can assign different roles to users via the *enum field `role` on the `User` model* with the possible values `ADMIN`, `MODERATOR` and `EDITOR`. This paves the way for **role-based permissions**, which are very useful if different kinds of users should have different access levels.

#### Elevated Access for Owners

Additionally, the relation `DocumentOwner` acts as the basis for **owner-based** permissions. Usually, we want to allow the owner of a node access to special operations, like deleting or publishing a document that the user owns.

#### Access Control Lists based on Relations

Finally, the `AccessGroup` model acts as way to express **relation-based** permissions. These are similar to *owner-based* permissions, but allow much more flexibility. The `accessLevel` enum field with possible values `READ`, `UPDATE` and `DELETE` can be used to define **access control lists or ACLs**.

## Whitelist Permissions for Modular Authorization

In general, permissions follow a **whitelist approach**:

* *no operation is permitted unless explicitely allowed*
* *a permission cannot be nullified by other permissions*

This allows us to think about authorization in a modular way. Focusing on a specific use case when defining a permission rule leads to many simple permissions instead of fewer complex ones.

We are classifying permissions in the different *operations* they are associated with - `View`, `Create`, `Update` and `Delete`.

### View Node: everyone can see published documents

Let's start this off by defining a simple rule:

> Everyone can query published documents.

```graphql
query permitViewDocuments($node_id: ID!) {
  someDocumentExists(filter: {
    id: $node_id
    published: true
  })
}
```

Note how the `$node_id` variable is used to check if the *queried node is published*. Only if this is the case will `someDocumentExists` return `true`, so the operation is granted permission.

#### Permission parameters

* **Operation:** `View Document`
* **Fields:** `id`, `content`, `published`, `title`
* **Audience:** `EVERYONE`

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
