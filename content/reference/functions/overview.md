---
alias: boo6uteemo
path: /docs/reference/functions/overview
layout: REFERENCE
description: Graphcool Functions are used to add different capabilities to your Graphcool project. Validate mutation input, extend your schema and more!
tags:
  - functions
related:
  further:
    - ejamaid4ae
  more:
---

# Functions

The business logic of any application is usually what accounts for its real value.
**Graphcool Functions** follows an **event-driven** concept that allows you to use functions as building blocks to get full control for the business logic needed for your individual use case.

Functions can be created in the [Functions View](!alias-ejamaid4ae) in the Console.

> Check the collection of [example functions on GitHub](https://github.com/graphcool-examples/functions).

## Use Cases for Functions

There are many different contexts that you can use a Graphcool Function in.

* The [Request Pipeline](!alias-pa6guruhaf) offers different hooks along the HTTP requests of your operations. Typical use cases for functions in the request pipeline are defining **custom validations**, **sending calls to external APIs** and more. Functions as part of the Request Pipeline are **synchronous**
* [Server-side subscriptions]() (formerly called mutation callbacks) allow you to get notified of special events **asynchronously**. This can be used to build custom integrations with external services like **sending emails when a User signs up**.

More use cases for functions are planned, for example **cron jobs**. Please let us know in [Slack](https://slack.graph.cool) or on [GitHub](https://github.com/graphcool/feature-requests/issues?q=is%3Aissue+is%3Aopen+label%3Aarea%2Ffunctions) if you have suggestions.

## Function Runtime

Whenever you use a function, you can choose between defining it inline or as a webhook.

### Inline Functions

**Inline functions** can be specified using the functions editor in the Console. They run on a node runtime and many npm modules are available for you to be imported.

Inline functions are managed in separate containers. For performance reasons, all functions within a project are executed in the same container, but there is no way for functions in different projects to interact with each other. As such, secret API Keys or other confidential information is kept secure when included in a function.

A centralized way to organize environment variables or secrets is planned and being discussed in [this feature request](https://github.com/graphcool/feature-requests/issues/229). Chime in to share your thoughts!

### Webhooks

Functions can also be deployed as **webhooks** using Function-as-a-service providers such as [Serverless](https://serverless.com/) and [AWS Lambda](https://aws.amazon.com/lambda/), [Google Cloud Functions](https://cloud.google.com/functions/), [Microsoft Azure Functions](https://azure.microsoft.com/) or by hosting the function yourself. Then you need to provide the webhook URL.

> Function executions time out after 10 seconds.

### Current Limitations

* Callbacks need to be converted to Promises. [Here's a guide](https://egghead.io/lessons/javascript-convert-a-callback-to-a-promise).
* Here's an [overview of currently available npm packges](https://tehsis.github.io/webtaskio-canirequire/). We are already working on [supporting any npm package](https://github.com/graphcool/feature-requests/issues/226).
