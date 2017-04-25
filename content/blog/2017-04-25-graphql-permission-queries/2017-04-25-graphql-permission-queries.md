---
alias: oolooch8oh
path: /blog/2017-04-25-graphql-permission-queries
layout: BLOG
description: Graphcool is introducing Permission Queries, a declarative authorization mechanism for GraphQL APIs.
preview: preview.png
publication_date: '2017-04-25'
tags:
  - permissions
  - announcement
related:
  further:
  more:
---

# Reinventing Authorization: GraphQL Permission Queries

GraphQL is the foundation for an entirely new way of thinking about APIs. Where GraphQL offers a very intuitive approach of how to design your API, it also [challenges developers to rethink](https://github.com/apollographql/graphql-tools/issues/313) the way how authorization works.

Authorization is one of the most important but often also one of the most complex aspects of a backend application. Even the smallest mistakes in this part of a system can have severe security implications.

Existing backend services such as Firebase only allow very limited and unflexible permission rules, ruling out most real-world applications and use-cases. When building Graphcool, this has always been in the center of our attention. From the very beginning, we have envisioned an expressive and powerful permission system enabling developers and companies to build real products.

## Introducing Permission Queries

Over the last six months, we've been working on an incredibly exiting addition to the permission system of the Graphcool platform. It's an entirely new concept we're calling "Permission Queries" which allows you to express any kind of relational permission logic just using a GraphQL query.

The idea is that for each operation (read, create, update, ...) you're specifying rules in form of a simple GraphQL query. Our permission engine will execute the query at the right time and based on the result (which is either `true` or `false`), the operation will be granted or denied. The idea behind these queries is to specify a condition based on your schema using the [filter system](!alias-aing7uech3).

Take a look at the following example to get a better understanding of how this works:

<!-- PERMISSION_EXAMPLES -->

The permission system follows a whitelist approach which means by default no operation is permitted unless explicitely allowed. For more details please read the [reference documentation about Authorization](!alias-iegoo0heez). You can also [read this guide](!alias-miesho4goo) to see how you can implement the permission logic needed for a CMS.

## A better level of abstraction

The right level of abstraction is one of the most important aspects about programming and building large systems. With the concept of permission queries, we're creating a new level of abstraction to think about and implement permission logic.

Building and maintaining an infrastructure like this requires and incredible amount of work and resources but we're convinced that this "trade of complexity" (i.e. we're doing the hard work) is worth it. Ultimately this enables you to focus on the core value of your applications without worrying about implementation details, infrastructure and performance.

In cases where permission logic isn't entirely based on relational information of your data graph, you'll [soon](https://github.com/graphcool/feature-requests/issues/183) be able to implement arbitrary permission rules using serverless functions. You will hear more about this soon!

> Interesting side note: This is also how Facebook's permission system works which has proven to be the most scalable and flexibel solution.

## Moving forward

A special thanks to more than 100 private beta testers, who helped us shaping this feature over the last months. We received an overwhelming amount of positive feedback and are very proud to make this feature available to all of our developers.

We hope this declarative authorization mechanism can be useful as well for other developers implementing thier own GraphQL server. We'll soon write up more backend implementation details in some more technical blog posts.

We couldn't be more excited for the future and can't wait to see what you'll be building!
