---
alias: oof5shiej3
path: /docs/faq/node-json-fields
layout: FAQ
description: Using node and Lokka you can easily create Json data. By using GraphQL variables and JSON stringify, we do not need to escape the data.
tags:
  - scripts
  - lokka
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

# Creating Json data with GraphQL and Lokka

With `node` it's simple to create Json data.
Using [Lokka](https://github.com/kadirahq/lokka), we can combine GraphQL variables with `JSON.stringify` and don't need to escape the Json input.

<!-- GITHUB_EXAMPLE('Create Json data', 'https://github.com/graphcool-examples/scripts') -->

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
node --harmony-async-await json-fields.js
```

```js
const {Lokka} = require('lokka')
const {Transport} = require('lokka-transport-http')

const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__')
})

const createEntry = async() => {
  // define a mutation with json and jsonList variables
  const mutation = `($json: Json, $jsonList: [Json!]) {
    createEntry(
      json: $json
      jsonList: $jsonList
    ) {
      id
      jsonList
    }
  }`

  // stringify an object for a single Json field
  const json = JSON.stringify({a: 2, message: "hello"})

  // stringify an array of objects for a [Json!] field
  const jsonList = JSON.stringify([{a: 2, message: "hello"}, {b: 3, message: "bye"}])

  // pass vars to mutation
  const vars = {
    json,
    jsonList
  }

  return await client.mutate(mutation, vars)
}

const main = async() => {
  const res = await createEntry()
  console.log('Created new entry:')
  console.log(res.createEntry)
  console.log('Done!')
}

main().catch((e) => console.error(e))
```
