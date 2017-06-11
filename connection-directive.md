---
alias: ujaesaen0s
path: /docs/tutorials/relay-modern-connection-directive
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

If you tried to get started with Relay Modern yourself, chances are that you took a look at the updated [Todo Example](https://github.com/relayjs/relay-examples/tree/master/todo-modern) project on GitHub. If you've also studied the [mutations](https://github.com/relayjs/relay-examples/tree/master/todo-modern) in these projects, you might have noticed the `@direction` directive that you need to specify when querying *lists* of items, Relay uses the concept of _connections_ for this.

This directive is new to Relay Modern and unfortunately doesn't have any official documentation yet. The directive takes two arguments:

- a `key`: specifies how Relay will refer to this connection in its internal cache
- a `filter`: represents an array of constraints that's used to filter the items in  connection

You'll notice the keys each being used twice throughout the project. Once for defining the connection in a GraphQL fragment, and once in the code that you used to update the cache after the mutation was performed.

Let's take a look at how it's used in the  example the example:

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

In `TodoList.js` is where you declare the data dependencies for the `TodoList` component in the form of a GraphQL fragment. `todos` refers to a [_connection_](https://github.com/relayjs/relay-examples/blob/master/todo-modern/data/schema.graphql#L135) that's defined in the GraphQL schema. When requesting the items from this list, the `@connection` directive is used alongside the `todos` field. Relay will use the specified key `TodoList_todos` in its internal cache to refer to that connection.

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

The key is used again in `AddTodoMutation.js`. This time, it's purpose is to pull the connection from the internal cache using the `ConnectionHandler` API. The key is passed to the call to `ConnectionHandler.getConnection(...)`. This allows you to retrieve list from the cache and update it manually with the new todo item that was created through the mutation.