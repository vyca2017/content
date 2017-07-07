---
alias: eijooto4se
path: /docs/tutorials/migrating-to-relay-modern
layout: TUTORIAL
preview: migrating-to-relay-modern.png
description: 'Learn how to migrate a project from Relay Classic to Relay Modern'
tags:
  - clients
  - relay-modern
  - relay-classic
  - relay
  - migration
  - upgrade
related:
  more:
    - iechu0shia
  further:
    - voht5ach9i
    - aizoong9ah
---


# Migrating to Relay Modern

Facebook's homegrown GraphQL client Relay finally was updated to its long-awaited 1.0 version: [Relay Modern](https://code.facebook.com/posts/1362748677097871/relay-modern-simpler-faster-more-extensible/). The goals of the new version are threefold:

* Making Relay more approachable by simplifying its API
* Improving performance
* Splitting Relay into separate packages to make it more extensible and flexible

<iframe width="560" height="315" src="https://www.youtube.com/embed/QcoEQzXWnKs" frameborder="0" allowfullscreen></iframe>

If you want to get an idea about the major changes in the new version, the updated (and majorly improved) [documentation](https://facebook.github.io/relay/docs/new-in-relay-modern.html) is a great place to start. Additionally, [Sashko](https://twitter.com/stubailo) from the Apollo team wrote an excellent in-depth [article](https://dev-blog.apollodata.com/exploring-relay-modern-276f5965f827) shedding light on different aspects of the new Relay Modern.

In the following post, we're going to explore what it's like to migrate a project from *Relay Classic* (yes, that's what the old API is called now) to its *Modern* counterpart. The project we're going to convert is a simple Todo app (TodoMVC). You can find the code for it on [Github](https://github.com/graphcool-examples/relay-modern-migration-example). Note that the repo contains a branch `classic`, representing the code before the conversion as well as a branch called `modern` with the upgraded code.

## Compatibility Mode

Facebook not only released a new version of Relay, they also included a dedicated API to help transition to it: [Relay Compat](https://facebook.github.io/relay/docs/relay-compat.html). This allows for developers to gradually migrate their existing code instead of having to go through one huge update process that would be accompanied by much sweat and tears.

Relay consists of two major parts:

* The API that allows developers to specify the data requirements for their components using on GraphQL fragments
* A runtime that receives the components' data requirements and implements the lower-level responsibilities related to networking and caching

The idea of Relay Compat is to allow updating the API while still working the old Relay runtime. This allows developer to update their apps component by component to using the new API without compatibility issues. The compatibility mode is available out-of-the-box with the new release candidate and can be accessed by importing from `react-relay/compat` instead of just `react-relay`.

> [Relay Docs](https://facebook.github.io/relay/docs/relay-compat.html#api-and-runtime): In order to incrementally convert an existing codebase, we will need to use the Relay Modern API while continuing to use the Relay Classic runtime until all components are converted.

## The "Conversion Playbook"

To ease the migration process, Facebook also released a [conversion playbook](https://facebook.github.io/relay/docs/conversion-playbook.html) that provides stepwise instructions to adopt Relay Modern. We'll use the following 5 steps as guidance for our migration process:

1. Updating the `react-relay` dependency to version 1.0
2. Gradually adjusting all React components to make use of the new API with Relay Compat
3. Replacing all occurrences of `Relay.RootContainer` and `Relay.Renderer` with `QueryRenderer`
4. Updating the runtime by introducing `RelayStaticEnvironment`
5. Cleaning up imports

In the following, we'll walk through these steps exploring each one in detail.

### 1. Installing Relay v1.0

#### Updating `react-relay`

Updating a project dependency to a new version with breaking changes can be scary. With Relay Modern, it's in fact not scary at all since all the old APIs are still accessible through `react-relay/classic`. (Would be great if more tools could have such a nice upgrade path.)

The new version of Relay can simply be installed with the following command (not that we're using the `dev` alias to get the release candidate of Relay):

```sh
yarn add react-relay@dev
```

To make sure the existing app still works, we now have to change all our imports from `react-relay` to `react-relay/classic`.

#### Installing the Relay Compiler

There are a few more things we have to do to completely finish this step, that is adding the Relay compiler as well as updating and configuring our `babel-plugin-relay`.

> A major part of the new release was untangling Relay into three major and independent components:
>
* [`relay-compiler`](https://github.com/facebook/relay/blob/master/packages/relay-compiler/ARCHITECTURE.md): *generic utility for parsing and optimizing GraphQL and generating code artifacts*
* [`relay-runtime`](https://github.com/facebook/relay/blob/master/packages/relay-runtime/ARCHITECTURE.md): *view library-agnostic generic utility for writing, sending, and caching GraphQL data*
* [`react-relay`](https://github.com/facebook/relay/tree/master/packages/react-relay): *integrates Relay with React, providing the container API demonstrated above*
>
> The descriptions for the packages are taken from the [announcement blog post](https://code.facebook.com/posts/1362748677097871/relay-modern-simpler-faster-more-extensible) by Lee Byron and Joe Savona.


First, let's add the Relay compiler:

```sh
yarn add --dev relay-compiler@dev
```

Once the Relay compiler is installed, we can use it by providing our source files and GraphQL schema as input arguments so that it can do its work:

```sh
relay-compiler --src ./src --schema ./schema.graphql
```

The `schema.graphql` represents our *full* GraphQL API expressed with the [GraphQL SDL (schema definition language)](!alias-kr84dktnp0/) syntax. It might be worth setting up an npm script in the `package.json` that makes this call:

```js
"scripts": {
  "relay": "relay-compiler --src ./src --schema ./schema.graphql"
}
```

### Setting up `babel-plugin-relay`

A key differentiator of Relay compared to other clients like [Apollo](http://www.apollodata.com/) is that it requires a build step to validate your GraphQL code against the schema of your API making sure all your requests are valid. This build step is implemented as a Babel plugin.

To make it very clear and avoid any confusion at this point:

* `babel-relay-plugin` is the **old** plugin (there also was an alternative called [babel-plugin-react-relay](https://github.com/graphcool/babel-plugin-react-relay))
* `babel-plugin-relay` is the **new** plugin

During the migration process, we can simply replace the old plugin. Let's install this (development) dependency first:

```sh
yarn add --dev babel-plugin-relay@dev
```

Now we have to incorporate it by including it as a plugin in our `.babelrc`:

```js
{
  "plugins": [
    ["relay", {"compat": true, "schema": "./schema.graphql"}]
  ]
}
```

We're passing our schema to the `relay` plugin too and tell it that we're in compatibility mode by specifying `true` for the `compat` flag.

### 2. Updating our code to the new Relay API

With Relay Modern, we can't use `RelayContainer` and `Relay.Mutation` any more. Instead, we'll use `FragmentContainer` and a new pattern to declare mutations using the `commitMutation` function.

#### From `Relay.Container` to `FragmentContainer`

Let's take a look at the `TodoList` component from our app to get a feeling for what we have to in that conversion:

```js
import Relay from 'react-relay'

// ...

export default Relay.createContainer(TodoList, {
  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        allTodoes(last: 1000) {
          edges {
            node {
              id,
              complete,
              ${Todo.getFragment('todo')},
            },
          },
        },
        ${Todo.getFragment('viewer')},
      }
    `,
  },
})
```

Here, the `TodoList` component declares its data requirements by means of a GraphQL fragment where it specifies that it needs access to all todos. It also pulls in the data requirements from the `Todo` component.

When converting, we need to switch from `Relay.createContainer` to using `createFragmentContainer` to wrap the `TodoList` component. Fragments are also not specified with `Relay.QL` any more but instead the `graphql` function is used:


```js
import {createFragmentContainer, graphql} from 'react-relay'

// ...

export default createFragmentContainer(TodoList, {
  viewer: graphql`
    fragment TodoList_viewer on Viewer {
      allTodoes(last: 1000) {
        edges {
          node {
            id,
            complete,
            ...Todo_todo,
          },
        },
      },
      ...Todo_viewer,
    }
  `,
})
```

Note that we're not using `getFragment()` any more to include sub-dependencies. Instead we're using regular GraphQL syntax to refer to a fragment (`...Todo_todo`). This means that all our fragments now live in a *global namespace* which greatly eases static analysis (read [Sashko's article](https://dev-blog.apollodata.com/exploring-relay-modern-276f5965f827) for more details on this). By convention, each fragment should be composed of the file name and the prop that it injects into the component: `<FileName>_<propName>`. **In compatibility mode, this convention is actually a hard requirement!**

#### Automatic migration with `jscodeshift`

Converting a lot of components by hand can become quite tedious, that's why Facebook provides a tool called [jscodeshift](https://github.com/facebook/jscodeshift) along with a transformation [script](https://github.com/relayjs/relay-codemod#migrate-to-modern-10) that converts your files automatically.

Converting the `Todo` component using `jscodeshift` looks as follows:

```sh
jscodeshift -t /<path>/relay-codemod/transforms/migrate-to-modern-1.0.js ./src/components/Todo.js
```

Let's quickly compare the input and output of that process as well. Here's what `Todo` looked like before the conversion:

```js
import Relay from 'react-relay'

// ...

export default Relay.createContainer(Todo, {
  fragments: {
    todo: () => Relay.QL`
      fragment on Todo {
        id,
        complete,
        text,
        ${ChangeTodoStatusMutation.getFragment('todo')},
        ${RemoveTodoMutation.getFragment('todo')},
        ${RenameTodoMutation.getFragment('todo')},
      }
    `,
    viewer: () => Relay.QL`
      fragment on Viewer {
        id,
        ${ChangeTodoStatusMutation.getFragment('viewer')},
        ${RemoveTodoMutation.getFragment('viewer')},
       }
    `,
  },
})
```

And this is the output of `jscodeshift`:

```js
import {createFragmentContainer, graphql} from 'react-relay'

// ...

export default createFragmentContainer(Todo, {
  todo: graphql`
    fragment Todo_todo on Todo {
      id,
      complete,
      text,
      ...ChangeTodoStatusMutation_todo,
      ...RemoveTodoMutation_todo,
      ...RenameTodoMutation_todo,
    }
  `,
  viewer: graphql`
    fragment Todo_viewer on Viewer {
      id,
      ...ChangeTodoStatusMutation_viewer,
      ...RemoveTodoMutation_viewer,
     }
  `,
})
```

Notice that because of the new mutation API, we actually can get rid of all the fragments here since mutations don't declare own data requirements in Relay Modern any more. Consequently, we can manually shorten this code:

```js
export default createFragmentContainer(Todo, {
  todo: graphql`
    fragment Todo_todo on Todo {
      id,
      complete,
      text,
    }
  `,
  viewer: graphql`
    fragment Todo_viewer on Viewer {
      id,
     }
  `,
})
```

> Note that `jscodeshift` currently just works for React components and not for mutations!

#### Update Mutations

A major change in Relay Modern is a new mutation API. Instead of subclassing `Relay.Mutation`, we can now call `commitMutation` and pass in an [*environment*](https://facebook.github.io/relay/docs/relay-environment.html) as well as an object to describe the mutation. In that object, we'll provide all necessary information about the mutation and how we want Relay to perform it.

We can follow ideas from Relay Classic by providing a [*Mutator configuration*](https://facebook.github.io/relay/docs/guides-mutations.html#mutator-configuration). A new opportunity in Relay Modern however is to pass in an `updater` function to imperatively update the store.

Let's take a look at the `ChangeTodoStatusMutation` we're using to toggle the `complete` status of a `Todo`. This is what it looks like before the conversion:

```js
export default class ChangeTodoStatusMutation extends Relay.Mutation {
  static fragments = {
    todo: () => Relay.QL`
      fragment on Todo {
        id,
        complete
      }
    `,
    viewer: () => Relay.QL`
      fragment on Viewer {
        id,
      }
    `,
  }

  getMutation () {
    return Relay.QL`mutation{updateTodo}`
  }

  getFatQuery () {
    return Relay.QL`
      fragment on UpdateTodoPayload {
        todo {
          complete,
        },
        viewer {
          allTodoes,
        },
      }
    `
  }

  getConfigs () {
    return [{
      type: 'FIELDS_CHANGE',
      fieldIDs: {
        todo: this.props.todo.id,
        viewer: this.props.viewer.id,
      },
    }]
  }

  getVariables () {
    return {
      complete: this.props.complete,
      id: this.props.todo.id,
    }
  }

  getOptimisticResponse () {
    var viewerPayload = {id: this.props.viewer.id}
    return {
      todo: {
        complete: this.props.complete,
        id: this.props.todo.id,
      },
      viewer: viewerPayload,
    }
  }
}
```

After the conversion, it'll look as follows:

```js
import {commitMutation, graphql} from 'react-relay/compat'

const mutation = graphql`
  mutation ChangeTodoStatusMutation(
    $input: UpdateTodoInput!
  ) {
    updateTodo(input: $input) {
      todo {
        id
        complete
      }
      edge {
        node {
          id
          complete
        }
      }
      viewer {
        allTodoes(last: 1000) {
          edges {
            node {
              id
              complete
            }
          }
        }
      }
    }
  }
`

function getConfigs(todoId, viewerId) {
  return [{
    type: 'FIELDS_CHANGE',
    fieldIDs: {
      todo: todoId,
      viewer: viewerId,
    },
  }]
}

function getOptimisticResponse (complete, todoId, viewerId) {
  const viewerPayload = {id: viewerId}
  return {
    todo: {
      complete,
      id: todoId,
    },
    viewer: viewerPayload,
  }
}

function commit(environment, todo, complete, viewerId) {
  return commitMutation(
    environment,
    {
      mutation,
      variables: {input: { id: todo.id, text: todo.text, complete, clientMutationId: 'asd' }},
      configs: getConfigs(viewerId),
      optimisticResponse: () => getOptimisticResponse(complete, todo.id, viewerId),
    }
  )
}

export default {commit}
```

This allows us to import the mutation as a single object and simply call the exported `commit` function on it:

```js
import ChangeTodoStatusMutation from '../mutations/ChangeTodoStatusMutation'

// ...

ChangeTodoStatusMutation.commit(
  this.props.relay.environment,
  complete,
  todo,
  this.props.viewer.id
)
```

### 3. Replace `Relay.RootContainer` with `QueryRenderer`

After we've converted all components and mutations, the next step is to replace all occurrences of `Relay.RootContainer` or `Relay.Renderer` with the new `QueryRenderer`. In our example app, we're only using the `Relay.RootContainer` at the moment:

```js
const root = <Relay.RootContainer
  Component={TodoApp}
  route={new ViewerRoute()}
  renderFetched={(data) => {
    return (
      <TodoApp
        {...data}
      />
    )
  }}
  renderLoading={() => <div>Loading</div>}
  renderFailure={(error) => <div>{error}</div>}
/>

ReactDOM.render(
  root,
  document.getElementById('root')
)
```

It can be replaced with an instance of the `QueryRenderer`:

```js
const root = <QueryRenderer
  environment={Relay.Store}
  query={graphql`
    query appQuery {
      viewer {
        ...TodoApp_viewer
      }
    }
  `}
  render={({error, props}) => {
    if (props) {
      return <TodoApp viewer={props.viewer} />
    } else {
      return <div>Loading</div>
    }
  }}
/>
```

Notice that at this point we still need to provide a `Relay.Store` from the Relay Classic API as the `environment` to ensure the app still works properly.

### 4. Updating the Relay Runtime

This step will bring the actual performance benefits to your app, from the [Relay docs](https://facebook.github.io/relay/docs/conversion-playbook.html#step-3-introduce-relay-modern-runtime): "Apps using the `RelayStaticEnvironment` get to send persisted query IDs instead of the full query strings to the server, as well as much more optimized data normalizing and processing."

Generally, what we have to do at this step is provide an instance of `RelayStaticEnvironment` to the `QueryRenderer` instead of the current `Relay.Store`.

[Relay Environment](https://facebook.github.io/relay/docs/relay-environment.html) is responsible for all the heavy lifting when it comes to data fetching and caching. It's instantiated with a [Network Layer](https://facebook.github.io/relay/docs/relay-environment.html) that specifies which GraphQL server Relay should talk to and additionaliy accepts configuration options, like HTTP headers for authentication or other purposes.

Here's how we create the Relay Environment in a dedicated file:

```js
import {
  Environment,
  Network,
  RecordSource,
  Store,
} from 'relay-runtime'

function fetchQuery(
  operation,
  variables,
) {
  return fetch('https://api.graph.cool/relay/v1/cj1nq71xyfabv0199bp3a7hhf', {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  }).then(response => {
    return response.json()
  })
}

const network = Network.create(fetchQuery)
const source = new RecordSource()
const store = new Store(source)

export default new Environment({
  network,
  store
})
```

In `app.js`, we can then directly import the environment and pass it to the `QueryRenderer`:

```js
import environment from './createRelayEnvironment'

// ...

const root = <QueryRenderer
  environment={environment}
  query={graphql`
    query appQuery {
      viewer {
        ...TodoApp_viewer
      }
    }
  `}
  render={({error, props}) => {
    if (props) {
      return <TodoApp viewer={props.viewer} />
    } else {
      return <div>Loading</div>
    }
  }}
/>
```

### 5. Clean up

The last step is simply cleaning up all the imports where we used `react-relay/classic` and `react-relay/compat`. Since we ensured that all our components are now using the new Relay APIs, we don't have to pull in the old Relay code any more. So, at this point running through our source files and adjusting all Relay imports to `react-relay` will do.

You can view the final state of the codebase [here](https://github.com/graphcool-examples/relay-modern-migration-example). Another important info for projects to be upgraded and making use of `react-relay-router` is that Relay Modern currently isn't supported by react-router-relay, but can be included with a slight workaround as explained in this [GitHub issue](https://github.com/relay-tools/react-router-relay/issues/234).

## Summary

Congratulations, you've now learned how to transform your existing Relay project to Relay Modern!

Relay Modern is an extremely promising iteration of Relay. Facebook did a great job in making sure that the migration from the previous version can be done in a smooth and iterative manner. An improved documentation and stepwise instruction for the update process vastly contribute to that.
