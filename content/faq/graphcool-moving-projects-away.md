---
alias: oobai3shoh
path: /docs/faq/graphcool-moving-projects-away
layout: FAQ
description: We're embracing open source and widely used technologies such as GraphQL and AWS Lambda and are dedicated to provide a good migration strategy.
tags:
  - platform
related:
  more:
    - ul6ue9gait
---

# How can I move my project away from Graphcool?

Graphcool is a venture-backed company dedicated to provide the best backend-as-a-service solution available. We don't plan to close shop anytime soon. Nevertheless, we give our best to give you a clear migration strategy in case you decide to not use Graphcool anymore.

## The value of BaaS products

Building a solid backend from scratch or even maintaining a backend in production is expensive and difficult. Relying on a backend as a service means that you can focus on building great products for your customers.

While some question BaaS as a concept based on the recent [shutdown of Parse](http://blog.parse.com/announcements/a-parse-shutdown-reminder/), Parse was a success even though it offered fairly limited possibilities. A big part of shutting it down comes down to a strategic move from Facebook as well, as continuing Parse didn't align with their primary goals.

It's important to note that Parse relied on proprietary software and was a fairly closed system. Using their client SDKs meant that your applications were highly coupled to Parse's implementation.

Graphcool is built on top of [open standards and widely used technologies](!alias-ul6ue9gait). This results in both an easier usage as well as a higher flexibility and makes the transition away from Graphcool fairly straightforward.

## Embracing Open Technologies

Graphcool is based on GraphQL and AWS Lambda and embraces openness and flexiblity over proprietary SDKs.

GraphQL is an [open specification](https://facebook.github.io/graphql/) with a vibrant community that maintains many tools for backend and frontend alike. Instead of using an SDK to communicate with GraphQL servers, open source clients such as [Relay](https://github.com/facebook/relay) and [Apollo Client](https://github.com/apollostack/apollo-client) are used.

While we are actively fostering the open source community with projects like [Learn Apollo](https://learnapollo.com) and [Learn Relay](https://learnrelay.org), the clients as well as surrounding support will be available to you whether you use Graphcool or not.

On top of that, our platform integrates nicely with different state-of-the-art solutions. For example, you can manage [ authentication with Auth0 and Digits](!alias-thoh9chaek), handle [payment workflows through Stripe](!alias-soiyaquah7) or rely on [Algolia for Search](!alias-aroozee9zu). We encourage you to implement your business logic workflows with serverless solutions such as [AWS Lambda](https://aws.amazon.com/lambda).

In combination, this means that migrating your project to an alternative backend is much simpler than previously possible, because your core product is decoupled from the backend implementation. To make this even easier, we're providing you with different options of exporting your project.

## Exporting a Graphcool project

A GraphQL schema is a type-safe contract between the GraphQL server and GraphQL clients based on the [GraphQL specification](http://facebook.github.io/graphql/). Every GraphQL server exposes its schema through so-called GraphQL inspection queries. You can use [get-graphql-schema](https://github.com/graphcool/get-graphql-schema) to download the schema for any GraphQL server or export the schema from the [Graphcool Console](!alias-uh8shohxie).

You are in control of your data stored on Graphcool at all times. You can easily download it with the *Export Data* feature in the project settings.

Exporting the GraphQL schema gives you great control over your project - mocking or bootstrapping GraphQL servers based on a GraphQL schema is possible with tools like [graphql-tools](http://dev.apollodata.com/tools/graphql-tools/index.html) or [graphql-sequelize](https://github.com/mickhansen/graphql-sequelize).
