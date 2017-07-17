---
alias: ook6luephu
path: /docs/faq/tips-and-tricks-graphql-playground
layout: FAQ
preview: graphql-playground.png
description: The GraphQL Playground GraphiQL is a super handy tool. Use these simple tricks for a great developer experience when working with GraphQL.
tags:
  - graphql
  - variable
  - queries
  - mutations
related:
  further:
    - oe1ier4iej
  more:
---

# Tips And Tricks: The GraphQL Playground

The GraphQL Playground GraphiQL is a super handy tool. Use these simple tricks for a great developer experience when working with GraphQL.

## Exploring The GraphQL Schema

The autocompletion feature is very helpful and gives suggestions as you type:

![](./graphql-autocompletion.gif)

> You can always activate the autocompletion suggestions using `Ctrl + Space`.

You can also explore the GraphQL schema using the `DOCS` tab built into the playground. Try to explore available queries and mutations, as well as the arguments for those operations:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts {
    id
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

## The `query` Keyword

Typically when defining a query, we're using the `query` keyword:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query {
  allPosts {
    id
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

However, there's a shorter version that looks like this:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
{
  allPosts {
    id
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

> When running a query, you don't have to specify the `query` keyword. However, for better readability it's recommended to always include it.

## Using GraphQL Comments

When working with queries in the playground, using the comment feature of GraphQL can be very useful. You can quickly select or deselect fields on a query, or switch between two different queries. Comments are activated with the `#` character.

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
# query all posts
query {
  allPosts {
    # only include the id for now
    id
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

You can actually use a shortcut to comment the current line in or out. Simple press `Ctrl + /` to enable or disable comments. This works if you select multiple lines as well.

## Defining Multiple Operations

When you need to use the same operations multiple times, the comment feature can become tedious to work with. Instead, you can simply define different operations at the same time. When you then use the play button, you can decide which operation you want to run.

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: false
---
query posts {
  allPosts {
		id
  }
}

mutation newPost {
  createPost(
    published: false
    slug: "new-post"
    title: "New Post"
    text: "A new post"
  ) {
    text
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "cixnen24p33lo0143bexvr52n"
      },
      {
        "id": "cixnenqen38mb0134o0jp1svy"
      },
      {
        "id": "cixneo7zp3cda0134h7t4klep"
      }
    ]
  }
}
```

> *Extra:* you can actually run the operation that is currently selected with your cursor by pressing `Ctrl + Enter`. This makes running different operations in sequence very fast.
