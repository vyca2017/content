---
alias: koht6ethe3
path: /docs/tutorials/relay-vs-apollo-mutations
layout: TUTORIAL
preview: relay-vs-apollo.png
description: 'Relay vs. Apollo Client: Learn about the differences between Relay and Apollo Client regarding GraphQL mutations based on an example.'
tags:
  - clients
  - mutations
  - relay
  - apollo-client
related:
  further:
    - ol0yuoz6go
    - koo4eevun4
    - heshoov3ai
    - aizoong9ah
  more:
    - iu5niesain
    - iep9yi0ri6
    - iph7aevae7
---

# Relay vs. Apollo - Mutations

Sending mutations is a core feature of any GraphQL client allowing you to modify data on a GraphQL backend.

## Overview

While calling mutations in both Relay and Apollo Client is done with mutation strings where GraphQL variables are injected, the two clients handle cache consistency in combination with mutations completely different.

Let's see how we can send the following GraphQL mutation with Relay and Apollo Client:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwdaxg682vpi0171tw2ga8fy
disabled: true
---
mutation {
  createPokemon(
    name: "Zapdos",
    types: [FLYING, ELECTRIC],
  	url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/145.png"
  ) {
    id
    name
  }
}
---
{
  "data": {
    "createPokemon": {
      "id": "ciy09vh0lja1e01108eo6ja34",
      "name": "Zapdos"
    }
  }
}
```

## Mutations with Relay

Defining mutations with Relay is very verbose and difficult to reason about. The reason is that Relay needs to know everything about the mutation in order to update the cache accordingly. A big upside however is that once we understand this system, Relay provides us with cache consistency for free.

In this mutation, we describe what Relay needs to know about the `createPokemon` mutation to first execute the mutation and then update the client side store to keep it data consistent.

* `fragments`, we specify the data needed by this mutation that is already a part of our data graph. In this case, we need the viewer id to be able to append a `pokemon` node to the `allPokemons` connection (see `getConfigs`)
* `getMutation`, we specify the name of the mutation
* `getFatQuery`, we specify all nodes, edges and connections in our data graph that may change due to this mutation
* `getOptimisticResponse`, we specify optimist data for the query response. We can only return data specified in the fat query and `viewer`
* `getConfigs`, we tell Relay what exactly happens with this mutation. The configuration `RANGE_ADD` needs a `parentName`, a `parentID` (that's what we need the `viewer` in the fragments for!), a `connectionName` and an `edgeName`. Additionally we need a list of `rangeBehaviors`, but typically `'': 'append'` is enough
* `getVariables`, we specify the additional variables needed for this mutation


```js
import Relay from 'react-relay'
export default class CreatePokemonMutation extends Relay.Mutation {

  // Specifies required data for this mutation.
  // Needs to be supplied together with `getVariables` defined below when calling this mutation
  static fragments = {
    viewer: () => Relay.QL`
      fragment on Viewer {
        id
      }
    `,
  }

  // Specifies mutation
  getMutation () {
    return Relay.QL`mutation{createPokemon}`
  }

  // Specifies what data may have changed due to this mutation
  getFatQuery () {
    return Relay.QL`
      fragment on CreatePokemonPayload {
        pokemon
        edge
        viewer {
          allPokemons
        }
      }
    `
  }

  //  defines an optimistic response to instantly update the UI. This will be overwritten if the mutation fails
  getOptimisticResponse () {
  return {
    edge: {
      node: {
        name: this.props.name,
        url: this.props.url,
      },
    },
    viewer: {
      id: this.props.viewer.id,
    },
  }
}

  // Uses RANGE_ADD type to add `pokemon` node to `allPokemons` edge
  getConfigs () {
    return [{
      type: 'RANGE_ADD',
      parentName: 'viewer',
      parentID: this.props.viewer.id,
      connectionName: 'allPokemons',
      edgeName: 'edge',
      rangeBehaviors: {
        '': 'append',
      },
    }]
  }

  // Required variables for this mutation.
  // Needs to be supplied together with objects defined in `fragments` above when calling this mutation
  getVariables () {
    return {
      name: this.props.name,
      url: this.props.url,
    }
  }
}
```

We can then call this mutation like this:

```js
Relay.Store.commitUpdate(
  new CreatePokemonMutation({name: this.state.name, url: this.state.url, viewer: this.props.viewer}),
  {
    onSuccess: (response) => console.log('created pokemon', response),
    onFailure: (transaction) => console.log('error', transaction),
  },
)
```

To find our more, you can read about other [mutation configurations](https://www.learnrelay.org/mutations/mutation-types) and [optimistic responses](https://www.learnrelay.org/mutations/optimistic-updates) or read the [official mutation documentation](https://facebook.github.io/relay/docs/guides-mutations.html).

## Mutations with Apollo Client

Calling mutations with Apollo Client is as simple as sending queries. However, quite often, mutation responses have to be integrated in the Apollo Store manually to ensure cache consistency.

First, we define a mutation with variables using the `gql` syntax and wrap a React component with `graphql` to later call the mutation:
```js
const createPokemonMutation = gql`
  mutation createPokemon($name: String!, $url: String!) {
    createPokemon(name: $name, url: $url) {
      id
      name
      url
    }
  }
`

const AddPokemonCardWithMutation = graphql(createPokemonMutation)(AddPokemonComponent)

export default AddPokemonComponentWithMutation
```

After the component is rendered, we can call the mutation like this:
```js
const {name, url} = this.state
this.props.mutate({variables: {name, url}})
  .then((data) => {
    console.log(data)
  })
```

To ensure cache consistency, we have to replace the definition of `AddPokemonComponentWithMutation` above with this:

```js
const AddPokemonComponentWithMutation = graphql(createPokemonMutation, {
  props({ ownProps, mutate }) {
    return {
      createPokemon({ variables }) {
        return mutate({
          variables: { ...variables },
          updateQueries: {
            allPokemonsQuery: (prev, { mutationResult }) => {
              const newPokemon = mutationResult.data.createPokemon
              return [...prev, newPokemon]
            },
          },
        })
      },
    }
  },
})(AddPokemonComponent)
```

What happens here with `updateQueries` is that we tell Apollo Client to update all places where we used the `allPokemonsQuery` to also include the new pokemon. If we have multiple queries that should be updated, we have to update them all individually. For example, consider this query:

```js
const TrainerQuery = gql`
  query TrainerQuery {
    Trainer(name: "Ash Ketchum") {
      ownedPokemons
    }
  }
`
```

We would have to include a `TrainerQuery` as part of the returned object in `updateQueries` as well.

To find our more, you can read about other [advanced mutations](https://www.learnrelay.org/mutations/mutation-types),  [managing Apollo Store](https://www.learnapollo.com/excursions/excursion-02) or read the [official mutation documentation](http://dev.apollodata.com/react/cache-updates.html).
