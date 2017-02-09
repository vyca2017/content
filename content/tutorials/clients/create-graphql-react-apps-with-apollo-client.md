---
alias: aidae4Aeg5
path: /docs/tutorials/create-react-apps-with-apollo-client
layout: TUTORIAL
preview: create-graphql-react-apps.png
description: Connecting to a GraphQL backend is really simple with create react app and Apollo Client.
tags:
  - react
  - clients
  - apollo
  - instagram
  - open-source
related:
  further:
    - koo4eevun4
    - nia9nushae
    - ol0yuoz6go
  more:
    - pheiph4ooj
    - ga2ahnee2a
---

# Create GraphQL React Apps with Apollo Client

The easiest way to get started with GraphQL React apps is using `create-react-app` and Apollo Client.
In this tutorial we will learn how we can construct an Instagram app, where posts are displayed, created or deleted. The complete code in this tutorial is [available on GitHub](https://github.com/graphcool-examples/react-apollo-instagram-example).

## Prerequisites

For this tutorial you need a GraphQL project with this schema:

```graphql
type Post {
  id: ID!
  description: String!
  imageUrl: String!
}
```

You can read the [quickstart guide](!alias-thaeghi8ro) to see how that is done!
Create some example posts and copy your endpoint. We will now build a React that queries a GraphQL server with Apollo Client and allows to display, create and delete posts.

## Installing Create React App

With `create-react-app`, it's super simple to initialize a React app that connects to a GraphQL backend! `create-react-app` comes with a lot of nice features out-of-the-box, such as a preconfigured Webpack and babel setup for zero build configurations. Furthermore, React, JSX, ES6, and Flow syntax support is included as well as language extras beyond ES6 like the object spread operator.

Let's install it:

```sh
npm install -g create-react-app
```

## Development with Create React App

After installing, we can easily create and run a new project from the command line:

```sh
create-react-app react-apollo-instagram-example
cd react-apollo-instagram-example/
npm start # open http://localhost:3000
```

Hot-reloading and linting is included as well, the terminal window keeps us updated about errors and linter problems.

## Using Apollo Client with a React App

#### Installing the Dependencies

Apollo Client is a popular GraphQL client. We'll use it to query our GraphQL backend. Let's install the needed packages:

```sh
npm install apollo-client react-apollo graphql-tag --save
```

Additionally, we're using React Router, so let's install that as well:

```sh
npm install react-router --save
```

For styling, we're using tachyons:

```sh
npm install tachyons --save
```

#### Mocking the needed Components

Let's first build the components needed for our Instagram app, where we want to display, create or delete posts.  Afterwards, we'll inject the needed data with Apollo Client and wire everything up with React Router.

These are the three components that we need:

* `ListPage` in `src/components/ListPage.js` that will list all posts in our backend.

```js
import React from 'react'
import { Link } from 'react-router'


class ListPage extends React.Component {

  render () {

    return (
      <div className='w-100 flex justify-center'>
        <Link to='/create' className='fixed bg-white top-0 right-0 pa4 ttu dim black no-underline'>
          + New Post
        </Link>
        <div className='w-100' style={{ maxWidth: 400 }}>
          TODO: Display all posts...
        </div>
      </div>
    )
  }
}

export default ListPage
```

* `CreatePost` in `src/components/CreatePage.js` to create new posts

```js
import React from 'react'
import { withRouter } from 'react-router'

class CreatePage extends React.Component {

  state = {
    description: '',
    imageUrl: '',
  }

  render () {
    return (
      <div className='w-100 pa4 flex justify-center'>
        <div style={{ maxWidth: 400 }} className=''>
          <input
            className='w-100 pa3 mv2'
            value={this.state.description}
            placeholder='Description'
            onChange={(e) => this.setState({description: e.target.value})}
          />
          <input
            className='w-100 pa3 mv2'
            value={this.state.imageUrl}
            placeholder='Image Url'
            onChange={(e) => this.setState({imageUrl: e.target.value})}
          />
          {this.state.imageUrl &&
            <img src={this.state.imageUrl} role='presentation' className='w-100 mv3' />
          }
          {this.state.description && this.state.imageUrl &&
            <button className='pa3 bg-black-10 bn dim ttu pointer' onClick={this.handlePost}>Post</button>
          }
        </div>
      </div>
    )
  }

  handlePost = () => {
    // TODO: create post before going back to ListPage
    console.log(this.state)
    this.props.router.push('/')
  }
}

export default withRouter(CreatePage)
```

* `Post` in `src/componens/Post.js` to display and delete a single post

```js
import React from 'react'

class Post extends React.Component {

  render () {
    return (
      <div className='pa3 bg-black-05 ma3'>
        <div
          className='w-100'
          style={{
            backgroundImage: `url(${this.props.post.imageUrl})`,
            backgroundSize: 'cover',
            paddingBottom: '100%',
          }}
        />
        <div className='pt3'>
          {this.props.post.description}&nbsp;
          <span className='red f6 pointer dim' onClick={this.handleDelete}>Delete</span>
        </div>
      </div>
    )
  }

  handleDelete = () => {
    // TODO: delete post before reloading posts
    this.props.refresh()
  }
}

export default Post
```

#### Setting up React Router and Apollo Client

First, add these styles in `src/index.ccs`:

```js
@import 'https://fonts.googleapis.com/css?family=Open+Sans:300,400';

body {
  margin: 0;
  padding: 0;
  font-family: 'Open Sans', sans-serif;
}

html {
  box-sizing: border-box;
}
*, *:before, *:after {
  box-sizing: inherit;
}
```

Now we're importing the needed packages in `src/index.js`

```js
import React from 'react'
import ReactDOM from 'react-dom'
import ListPage from './components/ListPage'
import CreatePage from './components/CreatePage'
import { Router, Route, browserHistory } from 'react-router'
import ApolloClient, { createNetworkInterface } from 'apollo-client'
import { ApolloProvider } from 'react-apollo'
import 'tachyons'
import './index.css'
```

Now we can create a new instance of Apollo Client below the import statements:

```js
const networkInterface = createNetworkInterface({
  uri: 'https://api.graph.cool/simple/v1/__PROJECT_ID__'
})

const client = new ApolloClient({
  networkInterface
})
```

Pass your project endpoint to the `uri` parameter of the `networkInterface` to connect the app to your GraphQL backend.

Now let's setup the needed routes for our application below:

```js
ReactDOM.render((
  <ApolloProvider client={client}>
    <Router history={browserHistory}>
      <Route path='/' component={ListPage} />
      <Route path='/create' component={CreatePage} />
    </Router>
  </ApolloProvider>
  ),
  document.getElementById('root')
)
```

Note that `ApolloProvider` is wrapping `Router`, which enables all child components to use Apollo Client for queries and mutations.

## Using Apollo Client for Queries and Mutations

Now we are ready to use Apollo Client in our different components!

#### Querying all Posts in `ListPage`

To display all posts in `ListPage`, we're adding three new imports in `src/component/ListPage.js`:

```js
import Post from '../components/Post'
import { graphql } from 'react-apollo'
import gql from 'graphql-tag'
```

Apart from `Post` to render a single post, we import `gql` and `graphql`. `gql` is used to create query and mutation. `graphql` takes queries and mutations created with `gql` and a React component and injects the data from a query or the mutation function to the component as a prop.

First, let's think about the query to display all posts:

```graphql
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: true
---
query allPosts {
  allPosts(orderBy: createdAt_DESC) {
    id
    imageUrl
    description
  }
}
---
{
  "data": {
    "allPosts": [
      {
        "id": "ciwcegunr21380122lvmexoga",
        "imageUrl": "https://images.unsplash.com/photo-1457518919282-b199744eefd6",
        "description": "#food"
      },
      {
        "id": "ciwcefwzhzhzg01229xcoi51f",
        "imageUrl": "https://images.unsplash.com/photo-1442407144300-e48b9dfe446b",
        "description": "#buildings"
      },
      {
        "id": "ciwcefmbs7tkz01260g21ncts",
        "imageUrl": "https://images.unsplash.com/photo-1450977894548-1b13203524f5",
        "description": "#nature"
      }
    ]
  }
}
```

At the end of the file, outside of the `Post` class, we are now adding the `FeedQuery` GraphQL query with `gql` that queries information of all our posts:

```js
const FeedQuery = gql`query allPosts {
  allPosts(orderBy: createdAt_DESC) {
    id
    imageUrl
    description
  }
}`
```

We're sorting the posts descending, so the latest posts appear on top of the list.

Now we're replacing the current `export` statement with this:

```js
export default graphql(FeedQuery)(ListPage)
```

This injects a new `data` prop to `ListPage`. Back in the `render` method of `ListPage`, we can first check if the data has been loaded with `this.props.data.loading`. If loading is `false`, the data has arrived and we can map over `this.props.data.allPosts` to display the posts. We're also passing the `this.props.data.refetch` method to every post to reexecute the query after a post has been deleted.

Combined, this is the `render` method that we end up with:

```js
render () {
  if (this.props.data.loading) {
    return (<div>Loading</div>)
  }

  return (
    <div className='w-100 flex justify-center'>
      <Link to='/create' className='fixed bg-white top-0 right-0 pa4 ttu dim black no-underline'>
        + New Post
      </Link>
      <div className='w-100' style={{ maxWidth: 400 }}>
        {this.props.data.allPosts.map((post) =>
          <Post key={post.id} post={post} refresh={() => this.props.data.refetch()} />
        )}
      </div>
    </div>
  )
}
```

#### Creating Posts in `CreatePage`

Adding mutations to React components is similar to adding queries, but instead of injected data, functions are injected for each mutation. Again, we need to import the Apollo Client related packages at the top of `src/components/CreatePage.js`:

```js
import { graphql } from 'react-apollo'
import gql from 'graphql-tag'
```

The mutation to create a new post looks like this:

```graphql
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: true
---
mutation addPost($description: String!, $imageUrl: String!) {
  createPost(description: $description, imageUrl: $imageUrl) {
    description
    imageUrl
  }
}
---
{
  "description": "#relax",
  "imageUrl": "https://images.unsplash.com/photo-1444492156724-6383118f4213"
}
---
{
  "data": {
    "createPost": {
      "description": "#relax",
      "imageUrl": "https://images.unsplash.com/photo-1444492156724-6383118f4213"
    }
  }
}
```

Now, at the end of the file, outside of the `CreatePage` class, but before the `export default withRouter(CreatePage)` statement, we can add a new mutation with `gql`:

```js
const addMutation = gql`
  mutation addPost($description: String!, $imageUrl: String!) {
    createPost(description: $description, imageUrl: $imageUrl) {
      id
      description
      imageUrl
    }
  }
`
```

Now we can replace the `export` statement by this:

```js
export default graphql(addMutation, {
  props: ({ ownProps, mutate }) => ({
    addPost: ({ description, imageUrl }) =>
      mutate({
        variables: { description, imageUrl },
      })
  })
})(withRouter(CreatePage))
```

This injects a new function to the props of `CreatePage` accessible with `this.props.addPost`. Using that, we can implement the `handlePost` method of the `CreatePage` class to create a post:

```js
handlePost = () => {
  const {description, imageUrl} = this.state
  this.props.addPost({ description, imageUrl })
    .then(() => {
      this.props.router.push('/')
    })
}
```

#### Deleting Posts in `Post`

To delete a post, we first import the Apollo Client related packages at the top of `src/components/Post.js`:

```js
import { graphql } from 'react-apollo'
import gql from 'graphql-tag'
```

This is how we can delete a post in the playground:

```graphql
endpoint: https://api.graph.cool/simple/v1/ciwce5xw82kh7017179gwzn7q
disabled: true
---
mutation deletePost($id: ID!) {
  deletePost(id: $id) {
    id
  }
}
---
{
  "id": "ciwcegunr21380122lvmexoga"
}
---
{
  "data": {
    "deletePost": {
      "id": "ciwcegunr21380122lvmexoga"
    }
  }
}
```

Now we can define the `deletePost` mutation, as always just before the `export default Post` statement:

```js
const deleteMutation = gql`
  mutation deletePost($id: ID!) {
    deletePost(id: $id) {
      id
    }
  }
`
```

## Conclusion

That's it! Using `create-react-app` and Apollo Client, it's easy to write GraphQL applications. If you want to dive deeper in the example code, it's [available on GitHub](https://github.com/graphcool-examples/react-apollo-instagram-example).

Apollo Client supports more features like subscriptions or [query batching](!alias-ligh7fmn38). For a more comprehensive tutorial, checkout [Learn Apollo](https://learnapollo.com), a hands-on guide for Apollo Client created by Graphcool.
