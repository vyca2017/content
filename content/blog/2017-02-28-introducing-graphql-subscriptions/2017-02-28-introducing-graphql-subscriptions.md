---
alias: in4ohtae4e
path: /blog/2017-02-28-introducing-graphql-subscriptions
layout: BLOG
description: Graphcool now supports building realtime apps with GraphQL Subscriptions.
preview: subscriptions-preview.png
publication_date: '2017-02-28'
tags:
  - platform
  - subscriptions
related:
  further:
    - aip7oojeiv
  more:
    - ui0eizishe
---

# Introducing GraphQL Subscriptions

Today we're excited to announce that Graphcool now supports building real-time apps with GraphQL Subscriptions.

## Subscriptions are coming...

It's an exciting time to be a GraphQL developer! Over the past six months developers behind Graphcool, Apollo, and the rest of the GraphQL community have been hard at work defining a stable Subscriptions API to bring powerful realtime capabilities to GraphQL. The effort has resulted in interoperability between clients, server implementations, and tools like GraphiQL.

![](./rfc.png?width=796)

Based on this community effort, Facebook has now started the formal process of adopting Subscriptions in the official GraphQL specification. If you are interested in participating, head over to [the RFC on GitHub](https://github.com/facebook/graphql/pull/267).

## Launching Subscriptions on Graphcool 🎉

Graphcool has participated in the specification effort from the start. We included many of you in this process by means of our Beta Program, where you provided invaluable feedback. We have incorporated all the learnings and are excited to announce today that **Subscriptions are now production ready on Graphcool**. ([See docs](!alias-aip7oojeiv))

As a Graphcool developer you understand how a flexible API allows you to iterate at high-speed and deliver value faster. The same experience is ingrained into the new Graphcool Subscriptions API. Client applications can simply define the events they want to be notified about using the familiar [GraphQL filter syntax](!alias-aing7uech3).

Take a look at the following example. This subscription query notifies you of all new photos by people followed by the current user:

```graphql
subscription {
  Photo(
    filter: {
      mutation_in: [CREATED]
      node: {
        creator: {
          followedBy_some: {
            id: "current-user-id"
          }
        }
      }
    }
  ) {
    node {
      id
      title
      url
    }
  }
}
```

## Subscriptions workflow using the Playground

One of GraphQLs best features are interactive tools like [GraphiQL](https://github.com/graphql/graphiql). For the best possible developer experience, the Graphcool Playground now supports GraphQL Subscriptions out of the box. Here is an example workflow:

![](http://graphcool-random.s3.amazonaws.com/images/subscriptions.gif)

## Try it out: Building a realtime chat app

To make it as easy as possible for you to get started with GraphQL Subscriptions, [we've prepared a tutorial](https://www.graph.cool/docs/tutorials/worldchat-subscriptions-example-ui0eizishe) for you. You will learn how to build a realtime chat app with GraphQL Subscriptions and Apollo.

Check out the [live demo](https://demo.graph.cool/worldchat/) to see how it looks like or dive into the [source code on Github](https://github.com/graphcool-examples/react-graphql/tree/master/subscriptions-with-apollo-worldchat). We've also recorded a video tutorial:

<iframe height="315" src="https://www.youtube.com/embed/aSLF9f13o2c" frameborder="0" allowfullscreen></iframe>

We hope you're as excited as we are about GraphQL Subscriptions and this release. To find out more, please take a look at the [reference documentation](!alias-aip7oojeiv). Finally, you can start exploring GraphQL Subscriptions in the interactive playground by [creating an account](http://console.graph.cool/signup).

As always, if you have any questions, feel free to reach out to us in [Slack](https://slack.graph.cool). 🙌
