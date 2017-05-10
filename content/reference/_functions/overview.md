---
alias: boo6uteemo
path: /docs/reference/functions/overview
layout: REFERENCE
description: Functions give developers a nice and familiar way to employ custom business logic.
tags:
  - functions
related:
  further:
    - uh8shohxie
    - ol0yuoz6go
  more:
    - saigai7cha
    - dah6aifoce
    - soiyaquah7
---

# Functions

The business logic of any application is usually what accounts for its real value.
*Graphcool Functions* follows an **event-driven** concept that allows you to use functions as building blocks for the business logic needed for your app.

You define functions by providing an **inline Javascript code** or a **webhook URL** to code hosted at platforms like AWS Lambda, Microsoft Azure, Google Cloud Functions or even to a self-hosted endpoint. This way you are in control of both the business logic itself as well as the infrastructure the code runs on.

## Use Cases for Functions

There are many different contexts that you can use a Graphcool Function in.

* The [Request Pipeline]() offers different hooks along the HTTP requests of your operations. Typical use cases for functions in the request pipeline are defining **custom validations**, **sending calls to external APIs** and more.
* [Server-side subscriptions]() (formerly called mutation callbacks) allow you to get notified of special events. This can be used to build custom integrations with external services like **sending emails when a User signs up**.

More use cases for functions are planned, for example **cron jobs**. Please let us know in [Slack](https://slack.graph.cool) or on [GitHub](https://github.com/graphcool/feature-requests/issues?q=is%3Aissue+is%3Aopen+label%3Aarea%2Ffunctions) if you have suggestions.
