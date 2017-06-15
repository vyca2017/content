---
alias: ih4etheigo
path: /docs/faq/calling-the-api-with-request
layout: FAQ
description: Send queries and mutations to the GraphQL client APIs from a Function using plain http requests.
tags:
  - functions
  - webtask
  - plain-http
  - client-apis
  - open-source
related:
  further:
    - heshoov3ai
    - koo4eevun4
    - wejileech9
  more:
  - taith2va1l
---

# Calling the API from a Function with plain HTTP

In mutation callbacks, you can run arbitrary code as a reaction to a mutation. Sometimes, you need to query additional data from your Graphcool endpoint or want to perform another mutation right in the function.

You can make calls to the [Simple API](!alias-heshoov3ai) or [Relay API](!alias-aizoong9ah) by doing plain HTTP requests or using a lightweight GraphQL client like Lokka. In this guide we will use plain HTTP requests to make calls to the Simple API of your Graphcool project.

> You can also read [the Lokka version of this guide](!alias-taith2va1l).

In this guide, we will again use our Instagram example. We will create a mutation callback that lets users automatically like a post that they created.

## 1. Preparation

### 1.1 Creating the `LikedPosts` relation

To keep track of which posts a user likes, let's create the `LikedPosts` relation.
It is a many-to-many relation, because a user can like many posts, and a post can be liked by many users at the same time.
So go ahead and create the relation between the `User` and `Post` models. Name the fields `likedPosts` and `likedBy`, respectively.

### 1.2 On permissions

Depending on your permission setup, the API calls in your mutation callback might need full access to your Graphcool project.

If you only want to perform operations that don't require special permissions and are available to [`EVERYONE`](!alias-soh5hu6xah), you are good to go.

To perform operations that aren't permitted to everyone, you can issue a new [permanent authentication token](!alias-eip7ahqu5o#token-types) in the [Console](https://console.graph.cool). Give the token a meaningful name so you remember what it belongs to later. You shouldn't use this token outside of server-side code, as it grants full read and write access to your project data.

We will see how to use the permanent authentication token soon.

### 1.3 Setting up webtask

You can use services like [AWS Lambda](https://aws.amazon.com/de/lambda/getting-started/) or [webtask](https://webtask.io/) to create an mutation callback handler that executes a certain part of your business logic whenever triggered. In this guide we will use webtask:

```sh
npm i -g webtask-cli
```

Read [here](https://webtask.io/cli) how to setup the webtask cli.

> This is just one of the many use cases you can solve with mutation callbacks. If you have an advanced requirement, AWS Lambda might be the better choice as it is more powerful than webtask.

## 2. Making API requests with plain HTTP

In this example, we use the `request` package to do HTTP requests.

Get the code from [the GitHub repository](https://github.com/graphcool-examples/webtask-like-posts-example/tree/master/request).

First, we insert our endpoint and permanent authentication token:

```js
  const endpoint = 'https://api.graph.cool/simple/v1/__PROJECT_ID__'
  const token = 'Bearer __PERMANENT_AUTH_TOKEN__'
```

Then we define the mutation that connects a user and post as part of the `LikedPosts` relation:

```js
  const mutation = `mutation {
    addToLikedPosts(likedPostsPostId: "${postId}", likedByUserId: "${userId}") {
      # we don't need the response but we have to select something
      likedByUser {
        id
      }
    }
  }`
```

Then we use `request.post` to send a HTTP POST request:

```js
  request.post({
    url: endpoint,
    headers: {
      'Authorization' : token,
      'content-type': 'application/json',
    },
    body: JSON.stringify({query: mutation}),
  }).on('error', (e) => {
    console.log('Error liking post: ' + e.toString())
    cb(e, {})
  }).on('response', (response) => {
    console.log('Response ' + JSON.stringify(response))
    cb(null, 'success')
  })
```

We include the `Authorization` and `content-type` headers and send the mutation as part of the `query` field in the body JSON.

That's all you need to do to talk to your API in a webtask. You could also do queries, for example to query all posts:

```js
const query =`query {
  allPosts {
    id
  }
}`
```

and then later:

```js
request.post({
  url: endpoint,
  headers: {
    'Authorization' : token,
    'content-type': 'application/json',
  },
  body: JSON.stringify({query: query}),
})
```

We don't have to bundle this code, so just create the webtask:

```sh
wt create like-posts-request.js
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
  createPost(
    description: "#graphcool"
    imageUrl: "not-found.png"
    authorId: "__ID__"
  ) {
    id
  }
}
```

Now switch back to the webtask logs and confirm that the webtask worked as expected. You can also go to the databrowser and check if your `User` node has a new post in its `likedPosts` field.

## 4. Next steps

Communicating to your API is as simple as that!

If you want to read more guides, you can check out how to [import data using a script](!alias-ga2ahnee2a).
