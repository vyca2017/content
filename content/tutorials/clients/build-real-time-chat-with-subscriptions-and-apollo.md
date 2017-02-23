---
alias: ui0eizishe
path: /docs/tutorials/worldchat-subscriptions-example
layout: TUTORIAL
preview:
shorttitle: How to Build Real-Time Chat with GraphQL Subscriptions
description: Build a real-time chat where the users can see the locations of all participants on a map - using GraphQL subscriptions and the Apollo client 
tags:
  - subscriptions
  - apollo
  - open-source
related:
  further:
    - aip7oojeiv
    - kengor9ei3
---

# How to build a Real-Time Chat with GraphQL Subscriptions and Apollo

In this tutorial, we explain how to build a chat application where the users can see their own and the locations of the other participants on a map. Not only the chat, but also the locations on the map get updated in real-time using GraphQL subscriptions.


## What are GraphQL Subscriptions?

_Subscriptions_ are a GraphQL feature that allow to get **real-time updates** from the database in a GraphQL backend. You set them up by _subscribing_ to changes that are caused by specific _mutations_ and then execute some code in your application to react to that change.

Using the Apollo client, you can benefit from the full power of subscriptions. Apollo [implements subscriptions based on web sockets](https://dev-blog.apollodata.com/graphql-subscriptions-in-apollo-client-9a2457f015fb#.fapq8d7yc). 

The simplest way to get started with a subscription is to specify a callback function where the modified data from the backend is provided as an argument. In a fully-fledged chat application where you're interested in any changes on the `Message` type, which is either that a _new message has been sent_, that _an existing message was modified_ or an _existing message was deleted_ this could look as follows:

```js
this.newMessageObserver = this.props.client.subscribe({
  query: gql`
    subscription {
      Message {
        mutation # contains `CREATED`, `UPDATED` or `DELETED` 
        node {
          text
          sentBy {
            name
          }
        }
      }
    }
  `,
  }).subscribe({
      next(data) {
      console.log('A mutation of the following type happened on the Message model: ', data.mutation)
      console.log('The changed data looks as follows: ',data.node)
    },
    error(error) {
      console.error('Subscription callback with error: ', error)
    },
})
```

> Note: This code assumes that you have configured and set up the `ApolloClient` and made it available in the `props` of your React component using [`withApollo`](http://dev.apollodata.com/react/higher-order-components.html#withApollo). We'll explain how to setup the `ApolloClient` in just a bit. 


#### Figuring out the Mutation Type

The _kind_ of change that happened in the database is reflected by the `mutation` field in the payload which contains either of three values:

- `CREATED`: for a node that was _added_
- `UPDATED`: for a node that was _updated_
- `DELETED`: for a node that was _deleted_ 
 
  
#### Getting Information about the changed Node

The `node` field in the payload allows us to retrieve information about the modified node. In the `DELETED` case you'll only be able to retrieve the `id` field of the deleted node in the payload.


#### Subscriptions with Apollo

Apollo uses the concept of an `Observable` (which you might be familiar with if you have worked with [RxJS](https://github.com/Reactive-Extensions/RxJS) before) in order to deliver updates to your application.

Rather than using the updated data manually in a callback though, you can benefit from further Apollo features that conventiently allow you to update the local `ApolloStore`. We used this technique in our example Worldchat app and will explain how it works in the following sections. 


## Setting up your Graphcool backend

First, we need to configure our backend. In order to do so, you can use the following [schema](https://www.graph.cool/docs/reference/platform/data-schema-ahwoh2fohj) file that represents the data model for our application:

```graphql
type Traveller {
	id: ID!
	createdAt: DateTime!
	updatedAt: DateTime!
	name: String!
	location: Location! @relation(name: "TravellerLocation")
	messages: [Message!]! @relation(name: "MessagesFromTraveller")
}

type Message {
	id: ID!
	createdAt: DateTime!
	updatedAt: DateTime!
	text: String!
	sentBy: Traveller!  @relation(name: "MessagesFromTraveller")
}

type Location {
	id: ID!
	createdAt: DateTime!
	updatedAt: DateTime!
	traveller: Traveller! @relation(name: "TravellerLocation")
	latitude: Float!
	longitude: Float!
}
```

Since the schema file is already included in this repository, all you have to do is download or clone the project and then use our CLI tool to create your project along with the specified schema:

```sh
git clone https://github.com/graphcool-examples/worldchat-subscriptions-example.git
cd worldchat
graphcool create Worldchat.schema
```

This will automatically create a project called `Worldchat` that you can now access in our [console](https://console.graph.cool).


## Setting up the Apollo Client to use Subscriptions

To get started with subscriptions in the app, we need to configure our instance of the `ApolloClient` accordingly. In addition to the GraphQL endpoint, we also need to provide a `SubscriptionClient` that handles the websocket connection between our app and the server. To find out more about how the `SubscriptionClient` works, you can visit the [repository](https://github.com/apollographql/subscriptions-transport-ws) where it's implemented.

To use the websocket client in your application, you first need to add it as a dependency:

```sh
yarn add subscriptions-transport-ws
```

Once you've installed the package, you can instantiate the `SubscriptionClient` and the `ApolloClient` as follows:

```js
import ApolloClient, { createNetworkInterface } from 'apollo-client'
import {SubscriptionClient, addGraphQLSubscriptions} from 'subscriptions-transport-ws'
import { ApolloProvider } from 'react-apollo'

// Create WebSocket client
const wsClient = new SubscriptionClient(`wss://subscriptions.graph.cool/__PROJECT ID__`, {
  reconnect: true,
  connectionParams: {
    // Pass any arguments you want for initialization
  }
})
const networkInterface = createNetworkInterface({ uri: 'https://api.graph.cool/simple/v1/__PROJECT ID__' })

// Extend the network interface with the WebSocket
const networkInterfaceWithSubscriptions = addGraphQLSubscriptions(
  networkInterface,
  wsClient
)

const client = new ApolloClient({
  networkInterface: networkInterfaceWithSubscriptions,
})
```

> Note: You can get the your `__PROJECT ID__` directly from our [console](https://console.graph.cool). Select your project and navigate to `Settings -> General`.

Now, as usual, you will have to pass the `ApolloClient` as a prop to the `ApolloProvider` and wrap all components that you'd like to access the data that is managed by Apollo. In the case of our chat, this step looks as follows:

```
class App extends Component {

  ...

  render() {
    return (
      <ApolloProvider client={client}>
        <WorldChat />
      </ApolloProvider>
    )
  }
}
```

You can view the full implementation [here](https://github.com/graphcool-examples/worldchat-subscriptions-example/blob/master/src/App.js).


## Building a Real-Time Chat with Subscriptions

Let's now look at how we implemented the chat feature in our application. You can refer to the [actual implementation](https://github.com/graphcool-examples/worldchat-subscriptions-example/blob/master/src/Chat.js) whenever you like.

All we need for the chat functionality is _one query_ to retrieve all messages from the database and _one mutation_ that allows us to create a new message:

```graphql
const allMessages = gql`
  query allMessages {
    allMessages {
      text
      createdAt
      sentBy {
        name
      }
    }
  }
`

const createMessage = gql`
  mutation createMessage($text: String!, $sentById: ID!) {
    createMessage(text: $text, sentById: $sentById) {
      id
      text
    }
  }
`
```

When exporting the component, we're making these two operations available to our component by wrapping them around it using the Apollo's higher-order compoment [`graphql`](http://dev.apollodata.com/react/higher-order-components.html#graphql):

```js
export default graphql(createMessage, {name : 'createMessageMutation'})(
  graphql(allMessages, {name: 'allMessagesQuery'})(Chat)
)
```

We then can subscribe for any changes on the `Message` type. 

> Note: Generally, a mutation can take one of three forms: `CREATED`, `UPDATED` or `DELETED`. Our subscription API allows to use a `filter` to specify which of these you'd like to subscribe to. If you don't specify a filter, you'll subsribe to _all_ of them by default. It is also possible to filter for more complex changes, e.g. for `UPDATED` mutations, you could only subscribe to changes that happen on a specific _field_.

```js
// Subscribe to `CREATED`, `UPDATED` and `DELETED` mutations
this.createMessageSubscription = this.props.allMessagesQuery.subscribeToMore({
  document: gql`
    subscription {
      Message {
        node {
          text
          createdAt
          sentBy {
            name
          }
        }
      }
    }
  `,
  updateQuery: (previousState, {subscriptionData}) => {
    const newMessage = subscriptionData.data.node
    const messages = previousState.allMessages.concat([newMessage])

    return {
      allMessages: messages,
    }
  },
  onError: (err) => console.error(err),
})
```

Notice that we're using a different method to subscribe to the changes compared the first example where we used `subscribe` directly on an instance of the `ApolloClient`. This time, we're calling [`subscribeToMore`](http://dev.apollodata.com/react/receiving-updates.html#Subscriptions) on the `allMessagesQuery` which is available in the `props` of our compoment because we wrapped it with `graphql` before.

Next to the actual subscription that we're passing as the `document` argument to `subscribeToMore`, we're also passing a function for the `updateQuery` parameter. This function follows the same principle as a [Redux reducer](http://redux.js.org/docs/basics/Reducers.html) and allows us to conveniently merge the changes that are delivered by the subscription into the `ApolloStore`.  It takes in the _previous state_ which is the the former _query result_ of our `allMessagesQuery` and the _subscription data_ which contains the payload that we specified in our subscription, in our case that's the `node` that carries information about the new message.

> From the Apollo [docs](http://dev.apollodata.com/react/receiving-updates.html#Subscriptions): `subscribeToMore` is a convenient way to update the result of a single query with a subscription. The `updateQuery` function passed to `subscribeToMore` runs every time a new subscription result arrives, and it’s responsible for updating the query result.

Fantastic, this is all we need in order for our chat to update in real-time! 🚀


## Complex Subscriptions

As mentioned before, our subscription API allows you to use powerful filters so that you can precisely specify what kind of changes you're actually interested in. You can read about all available features in our [documentation](https://www.graph.cool/docs/reference/simple-api/generated-subscriptions-aip7oojeiv).


### Filtering for Mutation Type:  `CREATED`, `UPDATED`, `DELETED` 

Maybe in your application you're only interested in the case when a new _node_ for one one of your model types is _added_. In that case, you could `filter` for mutations of type `CREATED` on your model. If we implemented that in our chat application, this would look as follows:


```graphql
subscription {
  Message(filter: {
    mutation_in: [CREATED]
  }) {
    node {
      text
      sentBy {
        name
      }
    }
  }
}
```

As mentioned before, in the `DELETED` case, we can only ask for the `id` of the deleted node in the payload of the subscription:

```graphql
subscription {
  Message(filter: {
    mutation_in: [DELETED]
  }) {
    node {
      id # this is the only field we can return
    }
  }
}
```


### Filtering on Fields

In an app with a `User` model that has a `username` and a `birthday` property, you might only be interested in users changing their usernames but not their birthdays. In that case, your subscription would look as follows:

```graphql
subscription {
  User(filter: {
    mutation_in: [UPDATED]
    updatedFields_contains: "username" # only notify when the username changes
  }) {
    node {
      id
      username # contains the new username
    }
    previousValues {
      username # contains the old username
    }
  }
}
```

Generally, you can include the information about which fields have changed in the payload of your subscription by specifying `updatedFields` in the subscription payload:

```graphql
subscription {
  User(filter: {
    mutation_in: [UPDATED]
  }) {
    updatedFields # contains a list of all the fields that have changed
  }
```

> Note: If you include `previousValues` or `updatedFields` in subscriptions on `CREATED` and `DELETED` mutations, they will just be `null`. 

You can of course also filter on fields for `CREATED` and `DELETED` mutations, e.g. if you only want to get notified about newly created messages that contain the word `"everyone"`:

```graphql
subscription {
  Message(filter: {
    mutation_in: [CREATED]
    node: {
      text_contains: "everyone"
    }
  }) {
    node {
      text
      sentBy {
        name
      }
    }
  }
}
```









