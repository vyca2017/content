---
alias: soiyaquah7
path: /docs/tutorials/stripe-payments-with-mutation-callbacks-using-micro-and-now
layout: TUTORIAL
preview: stripe-graphql.png
title: Stripe Payment Workflow with Mutation Callbacks
description: Use mutation callbacks to implement a custom Stripe payment workflow to verify credit card details and charge customers.
tags:
  - mutation-callbacks
  - functions
  - stripe
  - open-source
related:
  further:
    - uh8shohxie
    - ahlohd8ohn
  more:
    - saigai7cha
    - dah6aifoce
---

# Stripe Payment Workflow with Mutation Callbacks using micro and now

In this guide, we'll explore implementing a custom Stripe payment workflow with Graphcool mutation callbacks. While you can use any serverless solution like AWS Lambda or Auth0 webtask, we'll use Zeit's [micro](https://github.com/zeit/micro) and [now](https://zeit.co/now) in this tutorial.

You can find the code for this tutorial [here](https://github.com/graphcool-examples/micro-stripe-example).

## Register at Stripe

First, you need to register at [Stripe](stripe.com/) to obtain a **secret Stripe key** that allows you to add new Stripe customers and charge them. The secret key looks like this: `sk_test_XXXXXXXXXXXXXXXXXXXXXXXX`

> **Warning:** When following this guide, use the secret key associated with your **test account** to avoid charging real customers by accident. Once you are sure that all works as you intended, you can use your real Stripe account.

## Prepare your GraphQL schema

Next, we're preparing a Graphcool project for our example application. We're implementing a generic e-commerce platform where customers can sign up and order purchases. This is the according GraphQL schema:

```idl
type User {
  id: ID!
  name: String!
  email: String!
  password: String!
  stripeId: String
  orders: [Purchase]
  cardDetails: CardDetails
}

type CardDetails {
  id: ID!
  cardToken: String!
  user: User
}

type Purchase {
  id: ID!
  description: String!
  amount: Int!
  isPaid: Boolean!
  user: User
}
```

Here is a checklist of necessary steps to end up with the correct schema:

* Add fields `name`, `stripeId` to `User`
* Create `CardDetails` model with string field `cardToken`
* Create `Purchase` model with the fields string `description`, int `amount`, boolean `isPaid`
* Create one-to-one relation `UserCardDetails`, `user` - `cardDetails`
* Create one-to-many relation `UserPurchases`, `user` - `purchases`
* Enable email/password provider

## Permission setup

These are the permissions that we use in your application:

* everyone can create a User node - meaning that everyone can sign up
* authenticated users can add card details to their own user node

> Note: You can use permission queries to express the last permission like this:

```graphql
{
  allUsers(filter:{AND:[{id:$userId}, {id:$new_userId}]}){id}
}
```

Additionally, we'll need to generate a PAT to give our microservices access to read and modify data in our GraphQL backend.

## Deploy the microservices and mutation callbacks

> Note: You can use any serverless solution like AWS Lambda or Auth0 Webtask, or even host your own microservices. In this tutorial though, we're continuing with Zeit's micro and now.

We'll setup two microservices and each will be used for a different mutation callback. First, let's and now:

```sh
npm install -g now
```

Now add the needed secrets:

* `now secret add stripe-secret sk_test_XXXXXXXXXXXXXXXXXXXXXXXX`
* `now secret add gc-pat XXX`
* `now secret add endpoint https://api.graph.cool/simple/v1/__PROJECT_ID__`

Install the dependencies and deploy the microservices with now:

* `cd create && npm install && now -e STRIPE_SECRET=@stripe-secret -e GC_PAT=@gc-pat -e ENDPOINT=@endpoint createCustomer.js`
* `cd ../charge && npm install && now -e STRIPE_SECRET=@stripe-secret -e GC_PAT=@gc-pat -e ENDPOINT=@endpoint chargeCustomer.js`

The last two commands return a url that we need in the next step.

### When new card details are created, create according Stripe customer

Now we can add a new mutation callback with the trigger `CardDetails is created`. This mutation callback creates a new Stripe customer whenever new card details are created. Use this as its payload:

```graphql
{
  createdNode{
    id
    cardToken
    user {
      id
      email
      name
    }
  }
}
```

Enter the url of the `createCustomer.js` microservice from above.

### When purchase is created charge Stripe customer

We'll add another mutation callback that handles the actual charging when a new `Purchase is created`. Use this payload:

```graphql
{
  createdNode{
    id
    user {
      stripeId
    }
    amount
    description
    isPaid
  }
}
```

Enter the url of the `chargeCustomer.js` microservice from above.

## Test the Stripe Payment Workflow

### Create a user

We'll create a first user that we'll use to make test purchases:

```graphql
mutation {
  createUser(
    name: "Nilan",
    authProvider: {
      email: {
      	email: "nilan@graph.cool",
        password: "password"
      }
    }
  ) {
    id
  }
}
```

### Create card details with a Stripe card token

Now in your frontend application, you need to use one of Stripe's integrations to obtain a valid credit card token. Using Stripe.js, this code creates a valid token for a test credit card:

```js
Stripe.card.createToken({
  number: '4242424242424242',
  exp_month: 12,
  exp_year: 2018,
  cvc: '123'
}, function(status, response) {
  // response.id is the card token. now we cann call the mutation
  // createCardDetails(cardToken: "response.id", userId: "userId")
  // to new card details for the signed in user
  console.log(response.id)
})
```

Alternatively, you can generate a valid token for a test credit card and your account in the [Stripe documentation](https://stripe.com/docs#try-now).

Using the token we can now create new card details for our test user:

```graphql
mutation {
  createCardDetails(
    cardToken: "card-token",
    userId: "user-id"
  ) {
    id
  }
}
```

Now our first microservice should kick in and create a new Stripe customer according to the card and user details. Go to your Stripe account to confirm.

### Make a purchase

Now whenever the test user makes a purchase, the second microservice makes sure that the according Stripe customer we'll be charged. To confirm this, create a new test purchase in the Graphcool playground:

```graphql
mutation {
  createPurchase(
    amount: 50000,
    description: "A new laptop",
    isPaid: false
    userId: "user-id",
  ) {
    isPaid
  }
}
```

The mutation callback charges the according Stripe customer and sets `isPaid` to `true` to signify that the amount has been charged.

> Note: Stripe uses integers to express the amount of money charged. In this case, a total of 1000 equals 10 USD.

## Next steps

The mutation callback system as demonstrated is flexible enough to not only handle one-off purchases, but also Stripe Subscriptions for recurring payments, Stripe Connect for marketplace applications and more! You can find out more the available options using Stripe in the [Stripe documentation](https://stripe.com/docs).
