---
alias: da7pu3seew
path: /docs/reference/relay-api/one-to-one-edges
layout: REFERENCE
shorttitle: Modifying one-to-one edges
description: Modify edges for one-to-one relations with the Relay API and connect or disconnect two nodes in your GraphQL backend.
simple_relay_twin: zeich1raej
tags:
  - relay-api
  - mutations
  - relations
  - edges
related:
  further:
    - ahwoh2fohj
    - ek8eizeish
    - goh5uthoc1
  more:
    - chietu0ahn
---

# Modifying edges for one-to-one relations

A node in a one-to-one [relation](!alias-goh5uthoc1) can at most be connected to one node.

## Connect two nodes in a one-to-one relation

Creates a new edge between two nodes specified by their `id`. The according models have to be in the same [relation](!alias-goh5uthoc1).

The query response can contain both nodes of the new edge. The names of query arguments and node names depend on the field names of the relation.

> Consider a blog where every post at the most has one assigned category. Adds a new edge to the relation called `PostCategory` and query the category name and the post title:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  setPostMetaInformation(input: {
    metaInformationMetaInformationId: "cixnjj4l90ipl0106vp6u7a2f"
    postPostId: "cixnen24p33lo0143bexvr52n"
    clientMutationId: "abc"
  }) {
    metaInformationMetaInformation {
      tags
    }
    postPost {
      title
    }
  }
}
---
{
  "data": {
    "setPostMetaInformation": {
      "metaInformationMetaInformation": {
        "tags": [
          "GENERAL"
        ]
      },
      "postPost": {
        "title": "My biggest Adventure"
      }
    }
  }
}
```

Note: First removes existing connections containing one of the specified nodes, then adds the edge connecting both nodes.

You can also use the `updatePost` or `updateMetaInformation` to connect a post with a meta information:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  updatePost(input: {
    id: "cixnen24p33lo0143bexvr52n"
    metaInformationId: "cixnjj4l90ipl0106vp6u7a2f"
    clientMutationId: "abc"
  }) {
    metaInformation {
      tags
    }
  }
}

# or
# mutation {
#   updateMetaInformation(input: {
#    id: "cixnjj4l90ipl0106vp6u7a2f",
#    postId: "cixnen24p33lo0143bexvr52n"
#    clientMutationId: "abc"
#  }) {
#      post {
#        title
#      }
#   }
# }
---
{
  "data": {
    "updatePost": {
      "metaInformation": {
        "tags": [
          "GENERAL"
        ]
      }
    }
  }
}

# {
#   "data": {
#     "updateMetaInformation": {
#       "post": {
#         "title": "My biggest Adventure"
#       }
#     }
#   }
# }
```

## Disconnect two nodes in a one-to-one relation

Removes an edge of a node speficied by `id`.

The query response can contain both nodes of the former edge. The names of query arguments and node names depend on the field names of the relation.

> Removes an edge from the relation called `PostCategory` and query the category name and the post title:

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  unsetPostMetaInformation(input: {
    metaInformationMetaInformationId: "cixnjj4l90ipl0106vp6u7a2f"
    postPostId: "cixnen24p33lo0143bexvr52n"
    clientMutationId: "abc"
  }) {
    metaInformationMetaInformation {
      tags
    }
    postPost {
      title
    }
  }
}
---
{
  "data": {
    "setPostMetaInformation": {
      "metaInformationMetaInformation": {
        "tags": [
          "GENERAL"
        ]
      },
      "postPost": {
        "title": "My biggest Adventure"
      }
    }
  }
}
```
