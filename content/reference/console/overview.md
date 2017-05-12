---
alias: uh8shohxie
path: /docs/reference/console/overview
layout: REFERENCE
description: In the Graphcool console, you can manage multiple GraphQL projects, define your GraphQL schema and create or modify your data set.
tags:
  - platform
  - console
related:
  further:
    - ahwoh2fohj
    - wejileech9
    - heshoov3ai
    - aizoong9ah
  more:
    - thaeghi8ro
    - daisheeb9x
    - saigai7cha
    - dah6aifoce
---

# Console

With Graphcool you can create and configure multiple projects from within your indivual [console](http://console.graph.cool) that gives you access to your projects and allows you to change different settings.

## Models and Relations

[Models](!alias-ij2choozae) and [relations](!alias-goh5uthoc1) define your [data schema](!alias-ahwoh2fohj).

[Models](!alias-ij2choozae) consist of [fields](!alias-teizeit5se) that you can configure in the schema view. In the data browser you can get a quick overview of your existing data and add new data nodes.

[Relations](!alias-goh5uthoc1) allow you to define relationships between models. In the relations view you define new relations or review a previously defined relation.

## Permissions

With the [permission system](!alias-iegoo0heez) you can control which queries and mutations certain types of users are allowed to do. You can setup permissions for both [models](!alias-ij2choozae) and [relations](!alias-goh5uthoc1).

## Authentication

As part of the [authentication system](!alias-wejileech9), you can issue new [permanent authentication tokens](!alias-wejileech9#permanent-authentication-token) from within the console to give systems like internal services full control on your data.

## Mutation Callbacks

[Mutation callbacks](!alias-ahlohd8ohn) allow you to react on certain mutations providing an easy way to implement your custom business logic. For example if you are building an Instagram clone, you could send a notification email to a user whenever a new comment to one of his posts is created.

## Playground

The available queries and mutations for your project are automatically generated from your data schema and can be explored in the Playground view.

See [this tutorial](https://egghead.io/lessons/javascript-using-graphql-s-graphiql-tool) on how to effectively use the GraphiQL Playground.

## Client API Endpoints

To read or modify data from inside your app, you can make use of the [Simple API](!alias-heshoov3ai) or the [Relay API](!alias-aizoong9ah).
You can send requests to their respective endpoints that look like this:

`https://api.graph.cool/simple/v1/__PROJECT_ID__`
`https://api.graph.cool/relay/v1/__PROJECT_ID__`

For subscriptions you can use this endpoint:

`wss://subscriptions.graph.cool/v1/__PROJECT_ID__`

## File API Endpoint

The endpoint for [file management](!alias-aechiosh8u) in your project looks like this:

`https://api.graph.cool/file/v1/__PROJECT_ID__`
