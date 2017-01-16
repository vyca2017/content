---
alias: iph7aevae7
path: /docs/tutorials/relay-vs-apollo-queries
layout: TUTORIAL
preview: relay-vs-apollo.png
description: 'Relay vs. Apollo Client: See a comparison between sending GraphQL queries in Relay and Apollo Client based on an example GraphQL query.'
tags:
  - clients
  - queries
  - relay
  - apollo-client
related:
  further:
    - koo4eevun4
    - heshoov3ai
    - aizoong9ah
  more:
    - iu5niesain
    - iep9yi0ri6
    - koht6ethe3
---

# Relay vs. Apollo - Queries

Sending queries is a core feature of any GraphQL client allowing you to fetch data from a GraphQL backend.

## Overview

Both Relay and Apollo Client offer higher-order components (HCO) to define a query and inject its result to another React component. The internal cache is also updated with the results of a query to initate a potential rerender for all React components relying on the queried data. Relay's data normalization comes out-of-the-box based on the node ids a Relay-conforming GraphQL server provides. Apollo Client's data normalization needs to be setup manually but is more flexible on the other hand.

Let's see how we can send the following GraphQL query with Relay and Apollo Client:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/ciwdaxg682vpi0171tw2ga8fy
---
query {
  allPokemons(filter: {
    trainer: {
      name: "Ash Ketchum"
    }
  }) {
    id
    name
    url
  }
}
---
{
  "data": {
    "allPokemons": [
      {
        "id": "ciweua484po2v0132pwbff23p",
        "name": "Charmander",
        "url": "http://cdn.bulbagarden.net/media/upload/thumb/7/73/004Charmander.png/600px-004Charmander.png"
      },
      {
        "id": "ciweubn4qh6at0197pa72feyj",
        "name": "Bulbasaur",
        "url": "http://cdn.bulbagarden.net/media/upload/thumb/e/ea/001Bulbasaur_AG_anime.png/654px-001Bulbasaur_AG_anime.png"
      },
      {
        "id": "ciwf1cn7c02zn01610hw2m6gc",
        "name": "Squirtle",
        "url": "http://cdn.bulbagarden.net/media/upload/1/15/007Squirtle_XY_anime.png"
      },
      {
        "id": "ciwf6jo150ec20161e6usjku8",
        "name": "Pikachu",
        "url": "http://cdn.bulbagarden.net/upload/thumb/0/0d/025Pikachu.png/600px-025Pikachu.png"
      }
    ]
  }
}
```

## Queries with Relay

Relay heavily relies on GraphQL fragments to express queries. Every component that requires data from a GraphQL server needs to define an according GraphQL fragment. Parent components can include fragments from child components in their query without knowing the exact data requirements of their children. This concept is referred to as data masking.

### Wrapping a React component

To send a query with Relay, we have to wrap a React component using `Relay.createContainer`. The actual query is defined using the `Relay.QL` syntax seen below and we have to define a fragment on the viewer (or possibly another connection).


```js
// wrap Pokedex class with a RelayContainer and inject the data requirements via fragments
export default Relay.createContainer(
  Pokedex,
  {
    fragments: {
      viewer: () => Relay.QL`
        fragment on Viewer {
          allPokemons (
            filter: {
              trainer: {
                name: "Ash Ketchum"
              }
            },
            first: 1000
          ) {
            edges {
              node {
                id
                # include fields that appear in the `pokemon` fragment in `PokemonPreview`
                ${PokemonPreview.getFragment('pokemon')}
              }
            }
          }
          id
        }
      `,
    },
  },
)
```

Note the additional `first: 1000` argument that is required by Relay in queries like this. Relay specifies this and more arguments as part of the [Cursor Connections Specification](https://facebook.github.io/relay/graphql/connections.htm).

### Using the injected data in the React component

In the wrapped React component, we should specify props according to the defined fragments on the Relay container. In this case, we need to specify `viewer` that includes the `allPokemons` object.

```js
// the Pokedex class is responsible to display multiple pokemons
class Pokedex extends React.Component {
  // require the viewer prop type
  static propTypes = {
    viewer: React.PropTypes.shape({
      allPokemons: React.PropTypes.object,
    }),
  }

  render () {
    return (
      <div className='w-100 bg-light-gray min-vh-100'>
        <div className='flex flex-wrap justify-center center w-75'>
          // iterate the edges and nodes in the allPokemons connection
          {this.props.viewer.allPokemons.edges.map((edge) => edge.node).map((pokemon) =>
            <PokemonPreview key={pokemon.id} pokemon={pokemon} />)
          }
        </div>
      </div>
    )
  }
}
```

### Interaction with the cache

Relay requires the unique `id` field on every node in the GraphQL backend. The id is heavily used by Relay to normalize the data and make sure that all components rerender when there is new data for a certain node id. No more configuration is needed to make the cache consistent from the client side - however, there is also no possibility to change this behaviour. For example, for a GraphQL backend that only has unique `id`s per model, Relay's cache mechanisms would break. Graphcool uses [cuids](https://github.com/graphcool/cuid-java) to generate unique ids across all nodes in your project, so this is not an issue.

To read more about GraphQL queries in Relay, refer to the [Learn Relay guide](https://www.learnrelay.org/queries/what-is-a-query).

## Queries with Apollo Client

Apollo Client offers convenience functions to check the loading and error states of a query. This makes rendering a loading animation really simple. Using fragments with Apollo Client is an option, but it's not enforced.

### Wrapping a React component

To send a query with Apollo Client in React, we have to wrap a React component using `graphql`. The actual query is defined using the `gql` syntax seen below.

```js
const allPokemonsQuery = gql`
  query {
    allPokemons(filter: {
      trainer: {
        name: "Ash Ketchum"
      }
    }) {
      id
      name
      url
    }
  }
`

export default graphql(allPokemonsQuery)(Pokedex)
```

In the wrapped React component, we should specify the `data` prop. `data.loading` and `data.error` is always available. In our example we need to additionally specify the `allPokemons` array as property on `data`.

### Using the injected data in the React component

```js
// the Pokedex class is responsible to display multiple pokemons
class Pokedex extends React.Component {

  // require the data prop type
  static propTypes = {
    data: React.PropTypes.shape({
      loading: React.PropTypes.bool,
      error: React.PropTypes.object,
      allPokemons: React.PropTypes.array,
    }).isRequired,
  }

  render () {
    // data.loading informs about loading state - we can easily render a loading animation or a text
    if (this.props.data.loading) {
      return (<div>Loading</div>)
    }

    // in the case of an error with the query, data.error contains more information
    if (this.props.data.error) {
      console.log(this.props.data.error)
      return (<div>An unexpected error occurred</div>)
    }

    return (
      <div className='w-100 bg-light-gray min-vh-100'>
        <div className='flex flex-wrap justify-center center w-75'>
          {this.props.data.allPokemons.map((pokemon) =>
            <PokemonPreview key={pokemon.id} pokemon={pokemon} />
          )}
        </div>
      </div>
    )
  }
}
```

### Caching the queried data

To normalize the Apollo Store and uniquely identify nodes, you have to define the `dataIdFromObject` method when setting up the Apollo Client. Because nodes at Graphcool have a unique `id`, this setup is enough:

```js
const client = new ApolloClient({
  networkInterface: createNetworkInterface({ uri: 'https://api.graph.cool/simple/v1/__PROJECT_ID__'}),
  dataIdFromObject: o => o.id
})
```

With another GraphQL backend, your ids might only be unique per model. In this case, you can use this setup:

```js
const client = new ApolloClient({
  networkInterface: createNetworkInterface({ uri: 'https://api.graph.cool/simple/v1/__PROJECT_ID__'}),
  dataIdFromObject: o => o.__typename + o.id
})
```

In both cases, you have to make sure to include the `id` in all queries and mutations whose results should be normalized. To read more about GraphQL queries in Apollo Client, refer to the [Learn Apollo tutorial](https://www.learnapollo.com/tutorial-react/react-02/). There's also an [excursion on the Apollo Store](https://www.learnapollo.com/excursions/excursion-02).
