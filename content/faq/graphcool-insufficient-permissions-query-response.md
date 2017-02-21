---
alias: noohie9hai
path: /docs/faq/graphcool-insufficient-permissions-query-response
layout: FAQ
description: The GraphQL specification defines the interaction of optional or required fields in the query response with things like insufficient permissions.
tags:
  - queries
  - graphql
related:
  further:
    - teizeit5se
    - iegoo0heez
  more:
  - pheiph4ooj
---

# How do Insufficient Permissions affect the Query Response?

The permission system allows you to control data access on a field level. The [GraphQL specification](https://facebook.github.io/graphql/#sec-Types.Non-Null) defines the interaction of optional or required fields that cannot be returned for factors such as insufficient permissions.

Let's have a look how this affects the shape of query responses. We use this data model for demonstration purposes:

```idl
type Document {
  id: ID!
  public: String!
  optionalSecret: String
  requiredSecret: String!
  parent: Document
  child: Document
}
```

A document contains some `public` information that can be viewed, as well as an optional and required secret fields. Additionally, documents have a parent and a child document.

The permission setup allows `EVERYONE` to view the `public` field, but `optionalSecret` and `requiredSecret` are not allowed to be viewed. Let's consider these cases:

* All fields in the query are accessible
* An optional field in the query is not accessible
* An required field in the query is not accessible

## All Fields in the Query are Accessible

Let's query the `public` information of all documents.

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cizfedue03pfv0139ego227lv
disabled: false
---
query {
  allDocuments {
    public
  }
}
---
{
  "data": {
    "allDocuments": [
      {
        "public": "Everyone can read this!"
      },
      {
        "public": "And this as well"
      }
    ]
  }
}
```

This case is straight-forward. All fields are accessible, so the query response contains the information that was queried.

## An Optional Field in the Query is not Accessible

Now we also query for the optional field `optionalSecret` of all documents:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cizfedue03pfv0139ego227lv
disabled: false
---
query {
  allDocuments {
    public
    optionalSecret
  }
}
---
{
  "data": {
    "allDocuments": [
      {
        "public": "Everyone can read this!",
        "optionalSecret": null
      },
      {
        "public": "And this as well",
        "optionalSecret": null
      }
    ]
  },
  "errors": [
    {
      "locations": [
        {
          "line": 4,
          "column": 5
        }
      ],
      "path": [
        "allDocuments",
        0,
        "optionalSecret"
      ],
      "code": 3008,
      "message": "Insufficient Permissions",
      "requestId": "cizfflsqy5n4q0188qhz66euh"
    },
    {
      "locations": [
        {
          "line": 4,
          "column": 5
        }
      ],
      "path": [
        "allDocuments",
        1,
        "optionalSecret"
      ],
      "code": 3008,
      "message": "Insufficient Permissions",
      "requestId": "cizfflsqy5n4q0188qhz66euh"
    }
  ]
}
```

Even though an error is returned, the data that is valid is still included in the query response.

`optionalSecret` is returned as `null`, because it is not accessible. However, the data returned for other fields is not affected, in this case `public` still returns the correct value.

## A Required Field in the Query is not Accessible

Now we also add the required field `requiredSecret`, as part of the nested `child` node:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cizfedue03pfv0139ego227lv
disabled: false
---
query {
  allDocuments {
    public
    optionalSecret
    child {
      requiredSecret
    }
  }
}
---
{
  "data": {
    "allDocuments": [
      {
        "public": "Everyone can read this!",
        "optionalSecret": null,
        "child": null
      },
      {
        "public": "And this as well",
        "optionalSecret": null,
        "child": null
      }
    ]
  },
  "errors": [
    {
      "locations": [
        {
          "line": 4,
          "column": 5
        }
      ],
      "path": [
        "allDocuments",
        0,
        "optionalSecret"
      ],
      "code": 3008,
      "message": "Insufficient Permissions",
      "requestId": "cizfiq2r1rnh80191kukohdbw"
    },
    {
      "locations": [
        {
          "line": 6,
          "column": 7
        }
      ],
      "path": [
        "allDocuments",
        0,
        "child",
        "requiredSecret"
      ],
      "code": 3008,
      "message": "Insufficient Permissions",
      "requestId": "cizfiq2r1rnh80191kukohdbw"
    },
    {
      "locations": [
        {
          "line": 4,
          "column": 5
        }
      ],
      "path": [
        "allDocuments",
        1,
        "optionalSecret"
      ],
      "code": 3008,
      "message": "Insufficient Permissions",
      "requestId": "cizfiq2r1rnh80191kukohdbw"
    }
  ]
}
```

Because `requiredSecret` is a required field and is not accessible, the whole `child` node is returned as `null`. The parent node is not affected by this and `public` and `optionalSecret` show the same behaviour as discussed above.
