---
alias: aizoong9ah
path: /docs/reference/relay-api/overview
layout: REFERENCE
description: Relay API is supposed to be consumed by Facebook's GraphQL client Relay but any other GraphQL client such as Apollo, Lokka can be used as well.
simple_relay_twin: heshoov3ai
tags:
  - relay-api
related:
  further:
    - chohbah0eo
    - heshoov3ai
  more:
  - thaeghi8ro
  - iu5niesain
---

# Relay API

The Relay API is meant to be used with the GraphQL client Relay.

## Differences to the Simple API

The Relay API is conforming with the Relay specifications. If you don't use Relay as a GraphQL client you probably should use the [Simple API](!alias-heshoov3ai). You can also use different APIs in different parts of your application.

## Using the Relay API

### Connecting to the Relay API

Connect your application to the endpoint of your project to [make API requests](!alias-thaiph8ung).
The Relay API provides several possibilities to fetch, modify or traverse your data.

### Generated Queries

Depending on your models and relations, certain automatically [generated queries](!alias-oiviev0xi7) are available to fetch your data.

### Traversing the data graph

Using GraphQL, you can select the individual fields that the response of a query or mutation should contain. The GraphQL schema of your project is built according to your models and relations and allows you to [traverse the data graph](!alias-uo6uv0ecoh) in your query.

### Generated Mutations

Depending on your models and relations certain [generated mutations](!alias-vah0igucil) are available that allow you to modify your data.

### Errors

If something goes wrong when sending a query or mutation, [errors](!alias-looxoo7avo) are returned in the response enabling you to further investigate the issue.
