---
alias: seimeish6e
path: /docs/reference/integrations/overview
layout: REFERENCE
description: Graphcool integrates seamlessly with external services like Auth0 and Algolia. For even more flexibility you can use mutation callbacks.
tags:
  - integrations
related:
  further:
  more:
---

# Integrations

Graphcool integrates with different external services that can be configured in the [Integration View](!alias-uh8shohxie) of your project.

## Authentication Providers

Authentication is enabled by means of so called **authentication providers**. All authentication providers integrate seamlessly with the built-in [permission system](!alias-iegoo0heez).

* [Auth0](!alias-naed3eecie) offers authentication with popular social logins like Facebook, Google, Twitter or other methods like Passwordless.
* [Digits](!alias-iaxohpee8o) authenticates users with a passwordless SMS confirmation code, which they enter into your app to confirm their identity.
* The built-in [Email-Password authentication](!alias-fiayee5voh) is a simple alternative to third-party authentication providers.
* With the built-in [Anonymous authentication](!alias-ieph6iujah), users are identified with a unique secret instead of authentication credentials.

> Multiple auth providers can be enabled at the same time, but a single user can only authenticate with one authentication provider that is determined upon user signup.

## Full text search with Algolia

[Algolia](!alias-emaig4uiki) is a hosted Search API that delivers instant and relevant results. Using the Algolia integration, you can define Algolia search indices to automatically sync your model data to Algolia.

## More integrations

[Functions](!alias-boo6uteemo) can be used to integrate with any service that you like. Some examples are available in the public [Graphcool Functions collection](https://github.com/graphcool-examples/functions):

* Stripe: [create Stripe customers](https://github.com/graphcool-examples/functions/tree/master/stripe-create-customer) and [setup Stripe Subscriptions and Coupons](https://github.com/graphcool-examples/functions/tree/master/stripe-coupons).
* SendGrid: [Send an email using SendGrid](https://github.com/graphcool-examples/functions/tree/master/sendgrid-email).
* Slack: [Send Slack Notifications with Slack Bot](https://github.com/graphcool-examples/functions/tree/master/slack-bot-notifications).
* OneSignal: [Send a Push Notification with OneSignal](https://github.com/graphcool-examples/functions/tree/master/one-signal).
* Google Geocoding: [Fetch missing geo-data for an address with the Google Geocoding API](https://github.com/graphcool-examples/functions/tree/master/google-geocoding).
* Cloudinary: [Upload and transform an image using Cloudinary](https://github.com/graphcool-examples/functions/tree/master/cloudinary-images).
