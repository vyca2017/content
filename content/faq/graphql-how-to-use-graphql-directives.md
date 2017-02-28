---
alias: moach1gich
path: /docs/faq/how-to-use-graphql-directives
layout: FAQ
shorttitle: How t use GraphQL directives?
description: GraphQL directives encode additional functionalities. Using the skip and include directives you can control the shape of queries and mutations.
tags:
  - graphql
  - queries
  - mutations
related:
  further:
    - ol0yuoz6go
    - nia9nushae
  more:
    - cahzai2eur
---

# How to Use the GraphQL Directives Skip and Include?

GraphQL directives encode certain additional functionalities. Using the **skip** and **include** directives you can control the shape of queries and mutations using GraphQL variables.

## Shaping a Query Using Skip and Include

In the following query we fetch the description and comments for all posts:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query posts {
  allPosts {
    description
    comments {
      text
    }
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "description": "#nature",
        "comments": [
          {
            "text": "Nice picture!"
          },
          {
            "text": "What a beautiful view"
          }
        ]
      },
      {
        "description": "#buildings",
        "comments": []
      },
      {
        "description": "#food",
        "comments": [
          {
            "text": "Yummy"
          }
        ]
      }
    ]
  }
}
```

Let's now use the **skip** and **include** GraphQL directives to control whether we want to skip the `comments` field and include the `description` field. We'll use two boolean GraphQL variables as well. Try to change the values of the `skipComment` and `includeDescription` variables in this query:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: false
---
query posts($skipComments: Boolean!, $includeDescription: Boolean!) {
  allPosts {
    description @include(if: $includeDescription)
    comments @skip(if: $skipComments){
      text
    }
  }
}
---
{
  "skipComments": true,
  "includeDescription": true
}
---
{
  "data": {
    "allPosts": [
      {
        "description": "#nature"
      },
      {
        "description": "#buildings"
      },
      {
        "description": "#food"
      }
    ]
  }
}
```

* Fields marked with the `@skip` directive will be skipped if the passed boolean is true
* Fields marked with the `@include` directive will be included if the passed boolean is true

## Selecting a Mutation With GraphQL Directives

Sometimes we want to run a slightly different mutation depending on a specific condition. For example, if in an Instagram clone both guests and authenticated users can add new posts, we can use the following mutations to handle both cases. The boolean `withAuthor` can be used to control which of the two mutations is actually used:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: true
---
mutation createPost($withAuthor: Boolean!, $authorId: ID!) {
  post: createPost(
    description: "#bridge"
    imageUrl: "https://images.unsplash.com/photo-1420768255295-e871cbf6eb81"
  ) @skip(if: $withAuthor) {
    id
  }

  postWithAuthor: createPost(
    description: "#bridge"
    imageUrl: "https://images.unsplash.com/photo-1420768255295-e871cbf6eb81"
    authorId: $authorId
  ) @include(if: $withAuthor) {
    id
  }
}
---
{
  "withAuthor": true,
  "authorId": "ciwceb30dpiq10122fpak7xg0"
}
---
{
  "data": {
    "postWithAuthor": {
      "id": "cizpqa8yybuyo0115dhagfur9"
    }
  }
}
```
