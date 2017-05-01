---
alias: cae2ahz0ne
path: /docs/faq/using-graphql-fragments
layout: FAQ
preview: graphql-fragment.png
shorttitle: Using GraphQL Fragments
description: GraphQL fragments allow you to construct groups of fields that can be included in queries where you need them.
tags:
  - graphql
  - queries
related:
  further:
    - ua6eer7shu
    - aihaeph5ip
  more:
    - shoe5xailo
    - moach1gich
---

# Using GraphQL Fragments

GraphQL fragments are used to define a combination of fields that can be reused in different parts of your query.

## GraphQL Fragments And The Typename

When we are including the same set of fields in a query multiple times, we can define a fragment for the field set that can be reused. Let's try a fragment on the `Post` model:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query postAndComment {
  Post(id: "ciwcefmbs7tkz01260g21ncts") {
    __typename
    ... PostInfo
  }
  Comment(id: "ciwceizih4x9c01973arjtqsx") {
    post {
      ... PostInfo
    }
  }
}

fragment PostInfo on Post {
  description
  comments {
    id
  }
}
---
{
  "data": {
    "Post": {
      "__typename": "Post",
      "description": "#nature",
      "comments": [
        {
          "id": "ciwceibhj4x3s0197iksncyav"
        },
        {
          "id": "ciwceizih4x9c01973arjtqsx"
        }
      ]
    },
    "Comment": {
      "post": {
        "description": "#nature",
        "comments": [
          {
            "id": "ciwceibhj4x3s0197iksncyav"
          },
          {
            "id": "ciwceizih4x9c01973arjtqsx"
          }
        ]
      }
    }
  }
}
---
```

* with `fragment PostInfo on Post` we define a fragment on the `Post` model called `PostInfo`
* Now we can include the fragment anywhere in the query with `... PostInfo`

## Fetching A Single Node By Id

Typically, you would use the model-specific query to fetch a single node, in this case a `Post`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query postNode {
  Post(id: "ciwcefmbs7tkz01260g21ncts") {
    description
    comments {
      id
    }
  }
}
---
{
  "data": {
    "Post": {
      "description": "#nature",
      "comments": [
        {
          "id": "ciwceibhj4x3s0197iksncyav"
        },
        {
          "id": "ciwceizih4x9c01973arjtqsx"
        }
      ]
    }
  }
}
---
```

Using the `node` query, we can fetch a node without knowing its type:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query postNode {
  node(id: "ciwcefmbs7tkz01260g21ncts") {
    id
  }
}
---
{
  "data": {
    "node": {
      "id": "ciwcefmbs7tkz01260g21ncts"
    }
  }
}
---
```

However, we can't query much more than its id. Let's see how fragments can help us in this situation.

## Combining The Node Query With Fragments

By combining the `node` query with the `__typename` we can now define a fragment for both the `Comment` and the `Post` model. So depending on what type the node with the given id is, the response will look differently:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query postAndComment {
  Comment: node(id: "ciwceibhj4x3s0197iksncyav") {
    __typename
    ... Post
    ... Comment
  }

  Post: node(id: "ciwcefmbs7tkz01260g21ncts") {
    __typename
    ... Post
    ... Comment
  }
}

fragment Post on Post {
  description
  comments {
    id
  }
}

fragment Comment on Comment {
  text
}
---
{
  "data": {
    "Comment": {
      "__typename": "Comment",
      "text": "Nice picture!"
    },
    "Post": {
      "__typename": "Post",
      "description": "#nature",
      "comments": [
        {
          "id": "ciwceibhj4x3s0197iksncyav"
        },
        {
          "id": "ciwceizih4x9c01973arjtqsx"
        }
      ]
    }
  }
}
```

Using the `__typename` of the response, we can manage the response appropriately in our client and handle it depending on the type of the node.
