---
alias: heshoov3ai
path: /docs/reference/simple-api/overview
layout: REFERENCE
description: Simple API is supposed to be consumed by GraphQL clients such as Meteor's Apollo, Kadira's Lokka or simpler clients like curl or plain http.
simple_relay_twin: aizoong9ah
tags:
  - simple-api
related:
  further:
    - chohbah0eo
    - aizoong9ah
  more:
  - thaeghi8ro
  - iu5niesain
---

# Simple API

The Simple API is meant for GraphQL clients like Apollo or Lokka. If you are using Relay as your GraphQL client, check the [Relay API](!alias-aizoong9ah) instead.

## Differences to the Relay API

The Simple API can be thought of as a simpler version of the [Relay API](!alias-aizoong9ah). The two APIs don't differ too much in features, but mostly in usage. If you don't use Relay as a GraphQL client you probably should use the Simple API. If you decide to use Relay sometime later, you can easily switch to the Relay API or use both APIs.

## Using the Simple API

### Connecting to the Simple API

Connect your application to the endpoint of your project to [make API requests](!alias-koo4eevun4).
The Simple API provides several possibilities to fetch, modify or traverse your data.

### Generated Queries

Depending on your models and relations, certain automatically [generated queries](!alias-nia9nushae) are available to fetch your data.

### Traversing the data graph

Using GraphQL, you can select the individual fields that the response of a query or mutation should contain. The GraphQL schema of your project is built according to your models and relations and allows you to [traverse the data graph](!alias-aihaeph5ip) in your query.

### Generated Mutations

Depending on your models and relations certain [generated mutations](!alias-ol0yuoz6go) are available that allow you to modify your data.

### Generated Subscriptions

Depending on your models and relations, certain [generated subscriptions]() allow you to be notified in realtime of changes to your data.
All available subscriptions are automatically generated.

### Errors

If something goes wrong when sending a query or mutation, [errors](!alias-aecou7haj9) are returned in the response enabling you to further investigate the issue.
