---
alias: shu9xee3ou
path: /docs/faq/graphql-meta-information-for-relations
layout: FAQ
shorttitle: Meta Information for Relations
description: Relations describe the interaction between two models. To store additional information for connected nodes, you can introduce a meta model.
tags:
  - relations
  - data-schema
  - queries
  - graphql
related:
  further:
    - ahwoh2fohj
    - goh5uthoc1
  more:
  - eicha8ooph
  - daisheeb9x
  - ier7sa3eep
---

# How to Store Meta Information for Relations

Expressing the interaction between models can be done using relations. While models can be reasoned about separately, a relation highlights and consists of the relationship of two models.

Nevertheless, often we are interested in additional information for a pair of connected nodes in the relation. That's where we can introduce a *meta model* that stores this additional information.

## Modelling the Interaction of Nodes using Relations

Let's consider the following schema

```idl
type Subscriber {
  id: ID
  name: String!
  topics: [Topic] @relation(name: "FollowedTopics")
}

type Topic {
  id: ID
  title: String!
  followers: [Subscriber] @relation(name: "FollowedTopics")
}
```

that we might use in an application where users can subscribe to different topics. The `FollowedTopics` many-to-many relation stores the topics a user subscribed to.

## Introducing a new Meta Model for the Relation

While the current schema captures the interactions between subscribers and topics, we are currently limited in storing additional information for a specific user with respect to a specific topic. For example, we are interested if a topic is of high or low priority to a user, as well as when the subscription started.

To express the additional information, we can introduce a meta model `Subscription` with the according fields. Let's have a look at the resulting schema:

```idl
type Subscriber {
  id: ID
  name: String!
  susbriptions: [Subscription] @relation(name: "SubscriberOnSubscription")
}

type Topic {
  id: ID
  title: String!
  subscriptions: [Subscription] @relation(name: "SubscriptionOnTopic")
}

type Subscription {
  id: ID
  priority: SUBSCRIPTION_PRIORITY!
  subscribedAt: DateTime!
  topic: Topic @relation(name: "SubscriptionOnTopic")
  subscriber: Subscriber @relation(name: "SubscriberOnSubscription")
}

enum SUBSCRIPTION_PRIORITY {
  HIGH,
  LOW
}
```

Now, subscribers own multiple subscriptions via the `SubscriberOnSubscription` one-to-many relation, while topics can be related to multiple subscriptions as well, via the `SubriptionOnTopic` one-to-many relation.

## Querying Additional Information for Relations

With this data model, fetching data for a specific subscription becomes as easy as including the field in your query:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cizlhmdf2hkdr0172mhyyjehy
disabled: false
---
query {
  allSubscribers {
    name
    subscriptions {
      priority
      subscribedAt
      topic {
        title
      }
    }
  }
}
---
{
  "data": {
    "allSubscribers": [
      {
        "name": "Mickey",
        "subscriptions": [
          {
            "priority": "HIGH",
            "subscribedAt": "2017-02-02T00:00:00.000Z",
            "topic": {
              "title": "Cars"
            }
          },
          {
            "priority": "LOW",
            "subscribedAt": "2017-01-12T00:00:00.000Z",
            "topic": {
              "title": "Fashion"
            }
          }
        ]
      },
      {
        "name": "Minney",
        "subscriptions": [
          {
            "priority": "LOW",
            "subscribedAt": "2016-12-09T00:00:00.000Z",
            "topic": {
              "title": "Fashion"
            }
          },
          {
            "priority": "LOW",
            "subscribedAt": "2016-11-18T00:00:00.000Z",
            "topic": {
              "title": "Food"
            }
          }
        ]
      }
    ]
  }
}
```

Do you have further questions or suggestions regarding relation metadata? Share your thoughts [on GitHub](https://github.com/graphcool/feature-requests/issues/116)!
