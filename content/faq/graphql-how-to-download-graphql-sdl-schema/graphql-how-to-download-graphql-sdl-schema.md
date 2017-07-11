---
alias: maiv5eekan
path: /docs/faq/graphql-how-to-download-graphql-sdl-schema
layout: FAQ
title: How to download the GraphQL SDL Schema
description: GraphQL servers expose a type safe GraphQL schema. You can download it in SDL or JSON syntax and use it with Relay Modern or other tools.
tags:
  - tooling
  - schema
  - queries
  - graphql
related:
  further:
    - teizeit5se
    - ij2choozae
  more:
    - cahzai2eur
    - shoe5xailo
---

# How to download the GraphQL SDL Schema

The GraphQL schema describes the available types in a GraphQL API using the [SDL (schema definition language)](!alias-kr84dktnp0).

## Download a GraphQL Schema

You can use [get-graphql-schema](https://github.com/graphcool/get-graphql-schema) to download the complete GraphQL schema of any GraphQL endpoint. Install the tool and download the schema:

```sh
npm install -g get-graphql-schema
get-graphql-schema ENDPOINT_URL > schema.graphql
```

This downloads a GraphQL schema in SDL syntax, which is needed for Relay Modern for example. The schema contains **all necessary type information** for Relay Modern and other tooling. It contains available GraphQL queries and mutations, GraphQL types, mutation payloads, input types and more.

## Run an Introspection Query

You can also download the schema in JSON syntax based on a [GraphQL introspection query](!alias-shoe5xailo):

```sh
get-graphql-schema ENDPOINT_URL --json > schema.json
```
