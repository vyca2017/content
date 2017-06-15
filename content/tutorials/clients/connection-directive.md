---
alias: ujaesaen0s
path: /docs/tutorials/relay-modern-connection-directive
preview: connection-directive.png
layout: TUTORIAL
shorttitle: The @connection directive in Relay Modern 
description: Learn how Relay Modern uses the the @connection directive to refer to a list of items in the internal cache.
tags:
  - relay
  - relay-modern
  - connections
related:
  more: 
  further:
    - woodito7ug
---


# Relay Modern's @connection directive

If you tried to get started with Relay Modern yourself, chances are you came across the updated [Todo Example](https://github.com/relayjs/relay-examples/tree/master/todo-modern) project on GitHub. If you've also studied the [mutations](https://github.com/relayjs/relay-examples/tree/master/todo-modern) in that project, you might have noticed the `@connection` directive that you need to specify when querying *lists* of items.

This directive is new to Relay Modern and unfortunately doesn't have any official documentation yet. In this article, we want to give a brief overview on how to use it.

> In Relay, lists are represented through the concept of [_connections_](https://facebook.github.io/relay/docs/graphql-connections.html). This facilicates the implementation of a [cursor-based pagination](https://facebook.github.io/relay/graphql/connections.htm) approach on the client.

The `@connection` directive takes two arguments:

- `key`: specifies how Relay will refer to this connection in its internal cache
- `filter`: represents an array of constraints that are used to filter the items in the connection

Let's take a look at how the directive is used in the Todo example:

#### `TodoList.js`

```js
export default createFragmentContainer(TodoList, {
  viewer: graphql`
    fragment TodoList_viewer on User {
      todos(
        first: 2147483647  # max GraphQLInt
      ) @connection(key: "TodoList_todos") {
        edges {
          node {
            id,
            complete,
            ...Todo_todo,
          },
        },
      },
      id,
      totalCount,
      completedCount,
      ...Todo_viewer,
    }
  `,
```

In `TodoList.js`, the data dependencies for the `TodoList` component are declared in the form of a GraphQL fragment. `todos` refers to a [_connection_](https://github.com/relayjs/relay-examples/blob/master/todo-modern/data/schema.graphql#L135) that's defined in the GraphQL schema. When requesting the items from this list, the `@connection` directive is used alongside the `todos` field. Relay will use the specified key `TodoList_todos` in its internal cache to refer to that connection.

#### `AddTodoMutation.js`

```js
function sharedUpdater(store, user, newEdge) {
  const userProxy = store.get(user.id);
  const conn = ConnectionHandler.getConnection(
    userProxy,
    'TodoList_todos',
  );
  ConnectionHandler.insertEdgeAfter(conn, newEdge);
}
``` 

The key is used again in `AddTodoMutation.js`. This time, its purpose is to pull the connection from the internal cache using the `ConnectionHandler` API. The key is passed to the call to `ConnectionHandler.getConnection(...)`. This allows to retrieve the list from the cache and update it manually with the new todo item that was created through the mutation.
