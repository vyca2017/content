---
alias: oof5shiej3
path: /docs/faq/node-json-fields
layout: FAQ
description: Using node and graphql-request you can easily create JSON data with GraphQL. By using GraphQL variables and we do not need to escape the data.
tags:
  - scripts
  - graphql-request
  - node
  - open-source
related:
  further:
    - heshoov3ai
  more:
    - boneix7ohm
    - ga2ahnee2a
    - thaexex7av
---

# Creating Json data with GraphQL

With `node` it's simple to create Json data.
Using [`graphql-request`](https://github.com/graphcool/graphql-request), we can combine GraphQL variables with `JSON.stringify` and don't need to escape the Json input. You can see [the full code on GitHub](https://github.com/graphcool-examples/scripts/tree/master/json-entries).

In this example, we assume the following schema:

```graphql
type Entry {
  id: ID! @isUnique
  json: Json
  jsonList: [Json!]
}

```

* Copy your project endpoint and replace `__PROJECT_ID__`
* Install the dependencies with

```sh
yarn # or npm install
```

* Run the following script with

```sh
node json-fields.js
```

```js
const { request } = require('graphql-request')

const query = `mutation jsons($json: Json!, $jsonList: [Json!]!) {
  createEntry(
    json: $json
    jsonList: $jsonList
  ) {
    id
    json
    jsonList
  }
}`

const variables = {
  json: JSON.stringify({a: 'a'}),
  jsonList: [JSON.stringify({a: 'a'})]
}

request('https://api.graph.cool/simple/v1/__PROJECT_ID__', query, variables)
  .then(({ createJsons }) => console.log(createJsons))
```
