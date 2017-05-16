---
alias: ahde7paig2
path: /docs/blog/introducing-the-serverless-graphql-backend-architecture
layout: BLOG
preview: serverless-graphql-backend.png
publication_date: '2017-05-16'
description: Introducing the Serverless GraphQL Backend Architecture
tags:
  - mission
---

# Introducing the Serverless GraphQL Backend Architecture

At Graphcool we started writing apps combining GraphQL and serverless functions 1.5 years ago. As we became more familiar with both technologies we have found a few successful patterns that keep coming up in the applications we build. This blog post details how we build internal apps at Graphcool and how the Graphcool platform will evolve in the future.

## A Powerful API for Frontend and Backend

Applications implementing the Serverless GraphQL Backend Architecture rely on a powerful, automatically generated GraphQL API for all data access. The GraphQL API plays the same role as an object-relational mapper in traditional backend applications, with the important distinction that the GraphQL API is consumed equally by the frontend application and backend logic.

## Event-Driven Business Logic

A core tenant of the serverless architecture is carried over from the [Twelve-Factor App](https://12factor.net/) manifesto introduced by Heroku in 2012: Computation must happen in stateless short-lived functions. In the Serverless GraphQL Backend architecture, business logic is implemented in serverless functions that provide two fundamental building blocks:

* Asynchronous Events
* Synchronous Data Transformation

### Asynchronous Events

Often, application logic can be implemented with decoupled asynchronous events. Whenever possible, developers should favour this approach as it leads to applications that are easier to scale and maintain as load increases and more functionality is added.

The [event-driven architecture](https://en.wikipedia.org/wiki/Event-driven_architecture) is a proven tool in existing large scale backend development and is also very familiar to frontend developers dealing with the asynchronous nature of Javascript using frameworks like Redux.

Examples of business logic that fit very well into this model include:

* dispatching an order in an e-commerce webshop
* charging a credit card when an order is placed
* performing spam detection when a new comment is created

In a traditional event-driven architecture much work goes into deciding the right level of granularity for events. For example, does it matter that a user node is updated versus does it matter that a user changed an email address? The development team is forced to make decisions up front, with limited knowledge of how the application will evolve in the future.

The Serverless GraphQL Backend architecture sidesteps this issue completely by letting the event consumer decide what changes to be notified about using standard GraphQL subscription queries.

### Synchronous Data Transformation

Sometimes it is either not feasible or adds too much complexity to implement business logic using asynchronous events. This is when Synchronous Data Transformation should be used. Examples include:

* Validate the format of a shipping address
* Sanitizing and normalizing user input
* Retrieving extra information from an external system

Synchronous data transformations are typically used to validate and transform data before it is persisted. In applications implementing the Serverless GraphQL Backend architecture database writes are managed by GraphQL mutations.

A GraphQL mutation is a named action with typed input and output. The input type describes the data a client must provide to perform that action. The output type usually describes the shape of the persisted data. Mutations are part of the automatically generated GraphQL API.

In the Serverless GraphQL Backend architecture mutations implement a data transformation pipeline programming model. Each step in the pipeline is a Synchronous Data Transformation function with typed input and output. Each transformation step takes the output of the previous step and can either transform data or abort the request.

This programming model makes it possible to compose business logic that performs data validation and transformation.

## Connecting Functions with a Global Type System

Using the GraphQL type system it is possible to validate the data requirements of all serverless functions.

### Using GraphQL for Data Requirements Of Functions

GraphQL introduces a type system that enables frontend libraries like Relay to verify data dependencies and automatically fetch all required data. The Serverless GraphQL Backend architecture relies on this same type system to verify data dependencies for serverless functions.

We already saw that Synchronous Data Transformation functions must respect the input and output types of the mutations they are hooked into. If a mutation has multiple steps in the pipeline, each step must have an input type that matches the output type of the former.

Asynchronous Events specify their data requirements using a normal GraphQL subscription query exactly like the frontend application.

### Typed Serverless Functions

Asynchronous Events and Synchronous Data Transformation are implemented as serverless functions. We can think of serverless functions as modular business logic that is being plugged into the backend. The interface is clearly defined by GraphQL types allowing the backend to verify function input and output.

If serverless functions are implemented in a typed language we can go one step further and type-check each serverless function against their required input and output. Providing application wide type checking is a reason often stated for writing monolithic backend applications. The Serverless GraphQL Backend architecture brings the same level of type safety to serverless applications while maintaining the two main benefits:

* Better scalability as each function scales individually to match current workload
* Faster time-to-market as new business logic can be developed as independent modules


All new internal applications at Graphcool follow this architecture and we are starting to build support for these patterns directly into the Graphcool platform. Today we took the first step by [announcing Serverside Subscriptions and the Request Pipeline](!alias-teko4ab8za).
