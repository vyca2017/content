---
alias: uu2xighaef
path: /docs/tutorials/migrating-data-using-a-node-script
layout: TUTORIAL
preview: import-data-icon.png
description: When you want to bulk migrate your existing data, you can run a migration script that combines multiple GraphQL mutations in one GraphQL request.
tags:
  - scripts
  - data-schema
  - migration
  - lokka
  - open-source
related:
  further:
    - ahwoh2fohj
    - teizeit5se
    - wooghee1za
    - cahkav7nei
    - pa2aothaec
  more:
    - cahzai2eur
    - ga2ahnee2a
    - ier7sa3eep
    - taith2va1l
---

# Migrating Data using a Node Script

Sometimes you want to do a specific bulk migration on your existing data. You can use a migration script that combines [multiple mutations](!alias-cahzai2eur) so only one HTTP request is sent to the GraphQL backend.

In this guide we will see how a migration of potentially thousands of nodes can look like. First, we'll create a new project and populate it with test data of images. We will then run a simple script that does a bulk rename on all the images. Here, we use [Lokka](https://github.com/kadirahq/lokka) and Node, however you can choose whatever language and GraphQL client you prefer to run a migration script. You can find the code [here](https://github.com/graphcool-examples/migration-scripts/tree/master/images).

## 1. Setup a new project

Create a new Graphcool project with a `Image` type that has a required `name` field of type String as described in this schema:

```idl
type Image {
  id: ID!
  name: String!
}
```

Copy the **endpoint url** of your project for the next step.

## 2. Create test images

Let's create some test images named `1_sm.jpg`, `2_sm.jpg` and so on. In a following step, we want to rename these images to `1_lg.jpg`, `2_lg.jpg` and so on.

Consider the following script that creates the test images:

```js
const _ = require('lodash')
const {Lokka} = require('lokka')
const {Transport} = require('lokka-transport-http')

const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__')
})

const createImage = async(name) => {
  const result = await client.mutate(`{
    image: createImage(
      name: "${name}"
    ) {
      id
    }
  }`)

  return result.image.id
}

const main = async() => {
  const imageNames = _.range(10)
    .map(x => `${x}_sm.jpg`)

  console.log({imageNames})

  const images = await Promise.all(imageNames.map(createImage))

  console.log(`Created ${images.length} images`)
}

main().catch((e) => console.error(e))
```

You can run this script with

```sh
node createImages.js
```

Note that you have to replace `__PROJECT_ID__` with your **endpoint url** in this line:

```js
const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__')
})
```

This connects the GraphQL client Lokka with your project. Go back to your console and check if all images have been created in the data browser.

## 3. Migrate image names

First, we query all existing images to obtain their `id` and `name`:

```js
  const queryImages = async() => {
    const result = await client.query(`{
      images: allImages {
        id
        name
      }
    }`)

    return result.images
  }
```

Then we replace the names accordingly and construct one big request including the necessary `updateImage` mutations with a different GraphQL alias for each.

```js
const migrateImages = async(images) => {
  // beware! if your ids contain the string 'sm', adjust the string replacement accordingly!
  const updateMutations = _.chain(images)
    .map(image => ({ id: image.id, name: image.name.replace('sm', 'lg')}))
    .map(image => `
      ${image.id}: updateImage(id: "${image.id}", name: "${image.name}") {
        id
        name
      }`)
    .value()
    .join('\n')

  const result = await client.mutate(`{
    ${updateMutations}
  }`)

  console.log(`Updated ${Object.keys(result).length} images`)
  console.log(result)
}
```

**If the image names might contain the string `sm` elsewhere than in the `sm.jpg` part, this script will break!** In that case, please adjust accordingly.

Note that we're using aliases to include the same [mutation multiple times in one request](!alias-cahzai2eur).

That's it. If you have to update thousands of images, batching the mutations in say groups of a hundred might be better than to batch all of them in one request. Note that [mutations run sequentially](http://graphql.org/learn/queries/#multiple-fields-in-mutations) on the GraphQL server.

## 4. Migrating production projects

Migrations of production projects should be handled more carefully than migrating test projects. The following is a possible procedure to ensure a safe process:

* Ideally, lock down your production project so no further mutations can be run. This can be achieved by disabling all permissions.
* Clone your project.
* Run the migration script on your cloned project.
* Verify that the migration ran successfully. Double check that no data is lost and all migration steps have been executed correctly.
* Run the migration on your production project. You can use a permanent authentication token to give your script write access on your project even if all permissions are disabled.
* Verify that the migration ran successfully for the production project.
* Enable all previously disabled permissions.

Congratulations, you just migrated your project successfully!

## 5. Conclusion

You can read the complete code for the migration script [here](https://github.com/graphcool-examples/migration-scripts/tree/master/images).

While this approach is great for migrations that are as straightforward as in our example, it's not perfect for all situations. We're already thinking about creating an integrated experience for this use case, such as an interactive migration right in your Graphcool project with simulated migrations, validation checks and more. If you have ideas or further questions, come chat with us in [Slack](https://slack.graph.cool).
