---
alias: xa35dtag99
path: /blog/2017-03-14-graphql-up
layout: BLOG
description: Graphcool is introducing graphql-up, a CLI to get a free & ready to use GraphQL API.
preview: preview.png
publication_date: '2017-03-14'
tags:
  - cli
related:
  further:
    - vietahx7ih
  more:
    - heshoov3ai
    - aizoong9ah
---

# Introducing `graphql-up`

GraphQL is an amazing technology that makes working with APIs for frontend developers a breeze. However, just to try out GraphQL, you first have to develop your own GraphQL backend. This takes a lot of time until you can even run your first query.

At Graphcool, **we want to make it as easy as possible to get started with GraphQL.** That's why we've built [`graphql-up`](https://graph.cool/graphql-up/), a command-line tool that lets you spin up a ready-to-use GraphQL API by simply providing a GraphQL schema that describes your data model.

![](./terminal.gif)


## How to get your GraphQL API

First you need to install the CLI tool. `graphql-up` is available via NPM and can be installed using the following command (`yarn` also works of course):

```sh
npm install -g graphql-up
```

When calling `graphql-up` in the command line, all you need is to provide the [schema](!alias-kr84dktnp0#what-is-a-graphql-schema-definition) file for your backend as an argument. Here is an example schema for a simple version of Twitter:

```graphql
type User {
  id: ID!
  name: String!
  tweets: [Post!]! @relation(name: "Tweets")
}

type Tweet {
  id: ID!
  title: String!
  author: User @relation(name: "Tweets")
}
```

Simply save your schema in a file called `twitter.schema` and run the following command:

```sh
graphql-up twitter.schema
```

`graphql-up` will generate two different API endpoints for you:

1. [Simple API](!alias-heshoov3ai): Optimised for Apollo, but can be used with any GraphQL client
2. [Relay API](!alias-aizoong9ah): Optimized for Relay

Simply copy any of these endpoints into your app and start developing. You can also directly open an endpoint in your browser to access the GraphQL Playground (our enhanced version of GraphiQL).


## Add the ![graphql-up](http://static.graph.cool/images/graphql-up.svg) badge to your projects

You can also use `graphql-up` through a web-based flow outside of your terminal. The easiest way to do so is using the `graphql-up` badge.

Just add the following Markdown snippet and replace the __SCHEMA_URL__ with a link to your schema file. ([See here for a snippet generator.](/graphql-up/))

```md
[![graphql-up](http://static.graph.cool/images/graphql-up.svg)](https://www.graph.cool/graphql-up/new?source=__SCHEMA_URL__)
```

## Composition Is The Future of Software Development

We believe the future of software development belongs to small focused services. Combining these in countless ways developers will build complete applications with ease.

`graphql-up` completely eliminates the overhead of spinning up a GraphQL backend thereby enabling new use cases. At Graphcool we are heavy users of `graphql-up` both in our ci-infrastructure as well as for all demos we are giving.

We would love to talk to you about your use case - so head over to [Slack](https://slack.graph.cool).
