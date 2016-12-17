---
alias: ul6ue9gait
path: /docs/faq/graphcool-technology
layout: FAQ
preview: faq-icon.png
title: What technology is Graphcool using?
description: Learn more about the technology and infrastructure used at Graphcool.
tags:
  - platform
related:
  further:
    - uh8shohxie
    - eer4wiang0
    - ahlohd8ohn
---

# What technology is Graphcool using?

Graphcool runs on highly scalable cloud infrastructure provided by AWS and is based on industry standards and best practices.

## Infrastructure

Currently, all projects are hosted in Amazon's `eu-west-1` datacenter located in Ireland. Datacenters in the US and Asia are [coming soon](https://github.com/graphcool/feature-requests/issues/61).

* **Data Storage:** Your data is persisted in a high-availability cluster of [AWS Aurora](https://aws.amazon.com/rds/aurora/) databases combined with a Redis-powered caching layer.

* **File Storage:** Your uploaded files are securely stored in [Amazon S3](https://aws.amazon.com/s3/) and can be accessed through a fast CDN.

* **Business Logic:** Most of our business logic, such as the sign up workflow, is implemented as serverless functions and deployed to [AWS Lambda](http://docs.aws.amazon.com/lambda/latest/dg/welcome.html).

* **Website Hosting:** All our sites and SPAs are hosted on [Netlify](http://netlify.com)'s CDN.

## Software

Graphcool is built on top of great open-source software and we try to contribute back as much as possible.

* **Frontend:** We use React, Relay and TypeScript 2 for our console and make this project available as open-source [here](https://github.com/graphcool/console). We have several other packages that we use internally as open-source, such as [babel-plugin-react-relay](https://github.com/graphcool/babel-plugin-react-relay), [graphql-config](https://github.com/graphcool/graphql-config) or [prep](https://github.com/graphcool/prep).

* **Backend:** For our many microservices, we use Scala to benefit from its type-safety and [Sangria](https://github.com/sangria-graphql/sangria) to power our different schemas.
