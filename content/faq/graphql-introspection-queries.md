---
alias: shoe5xailo
path: /docs/faq/graphql-introspection-queries
layout: FAQ
title: How to use GraphQL Introspection Queries?
shorttitle: GraphQL Introspection Queries
description: GraphQL servers expose a type safe GraphQL schema. You can query information about the schema using GraphQL introspection queries.
tags:
  - tooling
  - queries
  - graphql
related:
  further:
    - teizeit5se
    - ij2choozae
  more:
  - cahzai2eur
---

# How to use GraphQL Introspection Queries

Every GraphQL server exposes a GraphQL schema that contains available types, queries and mutations. You can fetch information about the GraphQL schema using *introspection queries*. They enable awesome features for tools like the documentation view in the GraphiQL playground:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts {
    id
    metaInformation {
      tags
    }
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n",
        "metaInformation": {
          "tags": [
            "GENERAL"
          ]
        }
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy",
        "metaInformation": {
          "tags": [
            "GENERAL"
          ]
        }
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep",
        "metaInformation": {
          "tags": [
            "TRAVELLING"
          ]
        }
      }
    ]
  }
}
```

In the documentation view to the right, you can see all available operations, as well as expected input and output arguments. The best thing is that you can actually query all that information in your client application as well! You can use [this tool](https://github.com/graphcool/get-graphql-schema) to download the complete GraphQL schema of any GraphQL endpoint. Let's explore a few other useful introspection queries!

## Query the Fields of a Model

You can use the introspection capabilities of the GraphQL backend to query the available fields of a model. Let's see what fields are available for the `MetaInformation` model:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query fieldsOfMetaInformation {
  	__type(name: "MetaInformation") {
    	name
    	fields{
        name
        type {
          name
          kind
          ofType {
            name
            kind
            ofType {
              name
              kind
              ofType {
                name
                kind
              }
            }
          }
        }
      }
  	}
  }
---
{
  "data": {
    "__type": {
      "name": "MetaInformation",
      "fields": [
        {
          "name": "createdAt",
          "type": {
            "name": "DateTime",
            "kind": "SCALAR",
            "ofType": null
          }
        },
        {
          "name": "id",
          "type": {
            "name": null,
            "kind": "NON_NULL",
            "ofType": {
              "name": "ID",
              "kind": "SCALAR",
              "ofType": null
            }
          }
        },
        {
          "name": "post",
          "type": {
            "name": "Post",
            "kind": "OBJECT",
            "ofType": null
          }
        },
        {
          "name": "tags",
          "type": {
            "name": null,
            "kind": "NON_NULL",
            "ofType": {
              "name": null,
              "kind": "LIST",
              "ofType": {
                "name": null,
                "kind": "NON_NULL",
                "ofType": {
                  "name": "META_INFORMATION_TAGS",
                  "kind": "ENUM"
                }
              }
            }
          }
        },
        {
          "name": "updatedAt",
          "type": {
            "name": "DateTime",
            "kind": "SCALAR",
            "ofType": null
          }
        }
      ]
    }
  }
}
```

Using this query, we obtain several useful facts, for example:

* `id` is a required (or `NON_NULL`) scalar and of type `ID`
* `updatedAt` is of type `DateTime`
* `post` is of object type `Post`
* `tags` is a required list of required `META_INFORMATION_TAGS` which is an enum type

## Query all Enum Values

Another useful application of introspection queries is listing all available values for enum types. Let's find out what values are available for the `META_INFORMATION_TAGS` type:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query enumValuesOfMetaInformationTags {
  __type(name: "META_INFORMATION_TAGS") {
    name
    enumValues {
      name
    }
  }
}
---
{
  "data": {
    "__type": {
      "name": "META_INFORMATION_TAGS",
      "enumValues": [
        {
          "name": "GENERAL"
        },
        {
          "name": "TRAVELLING"
        }
      ]
    }
  }
}
```

Here we can see that the `META_INFORMATION_TAGS` offers the valid values `GENERAL` and `TRAVELLING`.
