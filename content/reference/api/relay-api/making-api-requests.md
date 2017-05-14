---
alias: thaiph8ung
path: /docs/reference/relay-api/making-api-requests
layout: REFERENCE
shorttitle: Making requests
description: Making requests to the Relay API can be done with Facebook's GraphQL client Relay or any other GraphQL client such as Apollo, Lokka or plain http.
simple_relay_twin: koo4eevun4
tags:
  - relay-api
  - relay
  - plain-http
related:
  further:
    - aechiosh8u
    - vah0igucil
    - yoh9thaip0
    - oiviev0xi7
  more:
    - cahzai2eur
    - ier7sa3eep
    - uu2xighaef

---

# Sending GraphQL Requests

To actually send a request to the Relay API, you first need to copy the [endpoint](!alias-yahph3foch#project-endpoints) URL assigned to your project, which looks like this:

`https://api.graph.cool/relay/v1/__PROJECT_ID__`

## Setup Relay

To set up the client with your endpoint, use Relay like this:

```javascript
Relay.injectNetworkLayer(
  new Relay.DefaultNetworkLayer('https://api.graph.cool/relay/v1/__YOUR_PROJECT_ID__')
);
```

To expose the GraphQL Schema to Relay, use [babel-plugin-react-relay](https://github.com/graphcool/babel-plugin-react-relay) and add this to `package.json`:

```javascript
"graphql": {
  "request": {
    "url": "https://api.graph.cool/relay/v1/__YOUR_PROJECT_ID__/"
  }
},
```

Now you can use Relay to do queries and mutations. If you are unsure about the Relay setup, check this [example Instragram app in Relay app](https://github.com/graphcool-examples/react-relay-instagram-example). For more information on how to use Relay, check the [official Relay documentation](https://facebook.github.io/relay/).
