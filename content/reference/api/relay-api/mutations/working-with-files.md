---
alias: aechiosh8u
path: /docs/reference/relay-api/working-with-files
layout: REFERENCE
shorttitle: Working with files
description: You can interact with the file management system, by uploading or modifying  files through GraphQL queries and mutations exposed in the Relay API.
simple_relay_twin: eetai5meic
tags:
  - relay-api
  - file-management
  - queries
  - mutations
related:
  further:
    - eefoovo2ah
  more:
    - yoh9thaip0
    - thaiph8ung
    - uo6uv0ecoh
---

# Working with files

To interact with the [file management](!alias-eer4wiang0) of the platform, you can create, rename or delete files through queries and mutations exposed in the Relay API.

## Uploading files

Coming soon. Right now, use [plain HTTP POST requests](!alias-eer4wiang0#uploading-a-file-with-plain-http) to upload files.

## Reading meta information of files

To query the meta information stored for a file, use the `allFiles` or `File` queries.

To query a specific file use one of the unique fields `id`, `secret` or `url` fields to [specify the file node](!alias-ga4chied8m):

```graphql
query {
  viewer {
    File(input: {
      id: "my-file-id"
    }) {
      file {
        id
        name
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "File": {
        "id": "my-file-id"
        "name": "comment.png"
      }
    }
  }
}
```

Similarly, the `allFiles` query can be used to query for [multiple file nodes](!alias-uu4ohnaih7).

## Renaming files

To rename a file, use the `updateFile` mutation and choose a new value for the `name` field:

```graphql
mutation {
  updateFile(input: {
    id: "my-file-id"
    name: "new-comment-name.png"
    clientMutationId: "abc"
  }) {
    file {
      id
      name
    }
  }
}
---
{
  "data": {
    "updateFile": {
      "file": {
        "id": "my-file-id"
        "name": "new-comment-name.png"
      }
    }
  }
}
```

## Deleting files

To delete a file, use the `deleteFile` mutation as you would use any other delete mutation:

```graphql
mutation {
  deleteFile(input: {
    id: "my-file-id"
    clientMutationId: "abc"
  }) {
    file {
      id
    }
  }
}
---
{
  "data": {
    "deleteFile": {
      "file": {
        "id": "my-file-id"
      }
    }
  }
}
```
