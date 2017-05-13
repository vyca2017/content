---
alias: boo6uteemo
path: /docs/reference/functions/overview
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
tags:
  - functions
related:
  further:
  more:
---

# Functions

The business logic of any application is usually what accounts for its real value.
**Graphcool Functions** follows an **event-driven** concept that allows you to use functions as building blocks to get full control for the business logic needed for your individual use case.

Functions can be created in the [Functions View]() in the Console.

## Use Cases for Functions

There are many different contexts that you can use a Graphcool Function in.

* The [Request Pipeline]() offers different hooks along the HTTP requests of your operations. Typical use cases for functions in the request pipeline are defining **custom validations**, **sending calls to external APIs** and more.
* [Server-side subscriptions]() (formerly called mutation callbacks) allow you to get notified of special events. This can be used to build custom integrations with external services like **sending emails when a User signs up**.

More use cases for functions are planned, for example **cron jobs**. Please let us know in [Slack](https://slack.graph.cool) or on [GitHub](https://github.com/graphcool/feature-requests/issues?q=is%3Aissue+is%3Aopen+label%3Aarea%2Ffunctions) if you have suggestions.

## Functions Runtime

Whenever you use a function, you can choose between defining it inline or as a webhook.
**Inline functions** can be specified using the functions editor in the Console. They run on a node runtime and every npm module is available for you to be imported.

Functions can also be deployed as **webhooks** using Function-as-a-service providers such as [Serverless]() and [AWS Lambda](), [Google Cloud Functions](), [Microsoft Azure]() or by hosting the function yourself. Then you need to provide the webhook URL.

> Function executions time out after 10 seconds.
