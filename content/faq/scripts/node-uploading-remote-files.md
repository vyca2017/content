---
alias: boneix7ohm
path: /docs/faq/node-uploading-remote-files
layout: FAQ
description: Using node and request you can upload remote files as form data.
tags:
  - files
  - node
  - open-source
related:
  further:
    - eer4wiang0
  more:
    - ga2ahnee2a
---

# Uploading Remote Files with Node

With `node` it's simple to upload remote files to Graphcool using the File API.
Using `request`, we can upload a file as [form data](https://developer.mozilla.org/en/docs/Web/API/FormData).

> Note: it's important to use the file key **`data`**, otherwise the file upload won't work!


<!-- GITHUB_EXAMPLE('Upload remote files with a node', 'https://github.com/graphcool-examples/node-remote-file-upload') -->

Run the following script with

```sh
node --harmony-async-await request.js
```

to upload the [graphql-up gif](http://imgur.com/7ROX2UT.gifv) to your Graphcool project:

```js
const request = require("request").defaults({
  encoding: null
})

const GRAPHQL_ENDPOINT = 'https://api.graph.cool/file/v1/__PROJECT_ID__'

function sendFile(path, fileName) {
  return new Promise((resolve, reject) => {
    request(path, (err, response, body) => {
      if (err) {
        console.log('ERROR: \n', err)
      }

      const r = request.post(GRAPHQL_ENDPOINT, (err, response, body) => {
        if (!err) {
          resolve(body)
        } else {
          reject(e)
        }
      })

      const form = r.form()
      form.append('data', body, {
        filename: fileName
      })
    })
  })
}

const main = async () => {
  await sendFile('http://imgur.com/download/7ROX2UT', 'graphql-up.gif')
}

main().catch((e) => console.error(e))
```
