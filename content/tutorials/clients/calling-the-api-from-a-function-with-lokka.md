---
alias: taith2va1l
path: /docs/tutorials/calling-the-api-with-lokka
layout: TUTORIAL
preview: calling-api-icon.png
description: Send queries and mutations to the GraphQL client APIs from a webtask using GraphQL Lokka.
tags:
  - functions
  - mutation-callbacks
  - webtask
  - lokka
  - client-apis
  - open-source
related:
  further:
    - heshoov3ai
    - koo4eevun4
    - wejileech9
  more:
    - ih4etheigo
    - saigai7cha
---


# Calling the API from a mutation callback with Lokka

In mutation callbacks, you can run arbitrary code like [sending a notification email](!alias-saigai7cha) or [getting an alert in your Slack channel](!alias-dah6aifoce) as a reaction to a mutation. Sometimes, you need to query additional data from your Graphcool endpoint or want to perform another mutation right in the function.

> If you want to follow along with this example, make sure to read the [starting guide](!alias-thaeghi8ro) on how to set up a GraphQL backend in less than 5 minutes first.

You can make calls to the [Simple API](!alias-heshoov3ai) or [Relay API](!alias-aizoong9ah) by doing plain HTTP requests or using a lightweight GraphQL client like Lokka. In this guide we will use [Lokka](https://github.com/kadirahq/lokka) to make calls to the Simple API of your Graphcool project.

> You can also read [the plain HTTP version of this guide](!alias-ih4etheigo).

In this guide, we will again use our Instagram example. We will create a mutation callback that lets users automatically like a post that they created.

## 1. Preparation

### 1.1 Creating the `LikedPosts` relation

To keep track of which posts a user likes, let's create the `LikedPosts` relation.
It is a many-to-many relation, because a user can like many posts, and a post can be liked by many users at the same time.
So go ahead and create the relation between the `User` and `Post` models. Name the fields `likedPosts` and `likedBy`, respectively.

### 1.2 On permissions

Depending on your permission setup, the API calls in your mutation callback might need full access to your Graphcool project.

If you only want to perform operations that don't require special permissions and are available to [`EVERYONE`](!alias-iegoo0heez#permission-level), you are good to go.

To perform operations that aren't permitted to everyone, you can issue a new [permanent authentication token](!alias-wejileech9#permanent-authentication-token) in the [Console](https://console.graph.cool). Give the token a meaningful name so you remember what it belongs to later. You shouldn't use this token outside of server-side code, as it grants full read and write access to your project data.

We will see how to use the permanent authentication token soon.

### 1.3 Setting up webtask

You can use services like [AWS Lambda](https://aws.amazon.com/de/lambda/getting-started/) or [webtask](https://webtask.io/) to create an mutation callback handler that executes a certain part of your business logic whenever triggered. In this guide we will use webtask:

```sh
npm i -g webtask-cli
```

Read [here](https://webtask.io/cli) how to setup the webtask cli.

> This is just one of the many use cases you can solve with mutation callbacks. If you have an advanced requirement, AWS Lambda might be the better choice as it is more powerful than webtask.

## 2. Making API requests with Lokka

In this example, we use the lightweight GraphQL client Lokka to do API calls.

Get the code from [the GitHub repository](https://github.com/graphcool-examples/webtask-like-posts-example/tree/master/lokka).

<!-- GITHUB_EXAMPLE('Webtask Like Posts', 'https://github.com/graphcool-examples/webtask-like-posts-example') -->

Let's look at the code together. We setup Lokka to connect to our project endpoint and add the permanent auth token for full access:

```js
const {Lokka} = require('lokka')
const {Transport} = require('lokka-transport-http')

const headers = {
  'Authorization': 'Bearer __PERMANENT_AUTH_TOKEN__'
}

const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__', {headers})
})
```

Make sure to insert your endpoint and permanent auth token.

In the exported function, we get the post and user id from the context data and use it to call the `addToLikedPosts` mutation:
```js
module.exports = (context, cb) => {
  console.log(context)

  const postId = context.data.createdNode.id
  const userId = context.data.createdNode.author.id

  client.mutate(`{
    addToLikedPosts(likedPostsPostId: "${postId}", likedByUserId: "${userId}") {
      # we don't need the response but we have to select something
      likedByUser {
        id
      }
    }
  }`)
    .then(() => cb(null, 'success'))
    .catch((e) => {
      console.log('Error liking post: ' + e.toString())
      cb(e, {})
    })
}
```

That's all you need to do to talk to your API in a webtask. You could also do queries, for example to query all posts:

```js
client.query(`{
  allPosts {
    id
  }
}`)
  .then((response) => {
    console.log(response.allPosts)
  })
```

Because we need external packages for Lokka, we have to bundle the code before creating the webtask.
All that can be done like that:

```sh
npm i -g webtask-bundle
wt-bundle like-posts-lokka.js --output build/like-posts-lokka.js -m
wt create build/like-posts-lokka.js
```

Copy the webtask url for later use.

## 3. Creating the mutation callback

Head over to your mutation callbacks in the Console and create a new mutation callback with the trigger `Post` `is created`.

Paste the webtask url from above as the handler and enter this payload:

```js
{
  createdNode{
    id
    author {
      id
    }
  }
}
```

Now you can create a new post to test the webtask. First, open the webtask logs:

```sh
wt logs
```

Then, in your playground, get the id of a user that should author a new post:

```graphql
query {
  allUsers {
    id
  }
}
```

Copy the id and create a new post:

```graphql
mutation {
  createPost(description: "#graphcool", imageUrl: "not-found.png", authorId: "__ID__") {
    id
  }
}
```

Now switch back to the webtask logs and confirm that the webtask worked as expected. You can also go to the databrowser and check if your `User` node has a new post in its `likedPosts` field.

## 4. Next steps

Communicating to your API is as simple as that!

If you want to read more guides, you can check out how to [import data using a script](!alias-ga2ahnee2a).
