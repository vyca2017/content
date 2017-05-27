---
alias: ga2ahnee2a
path: /docs/faq/importing-simple-data
layout: FAQ
description: Use a script to import simple JSON data to your GraphQL backend.
tags:
  - scripts
  - data-management
  - data-import
  - lokka
  - plain-http
  - open-source
related:
  further:
    - koo4eevun4
    - ahwoh2fohj
  more:
    - aing2chaih
    - ier7sa3eep
    - eefoovo2ah
    - uu2xighaef
---

# Importing simple data using a script

Importing existing data to one of your Graphcool projects manually can be quite tedious. Depending on the amount of data you have, using an import script can be the better approach for this task. This is done in two steps. First, we prepare the data schema of the Graphcool project. Then we can run a script that populates the project with the existing data.

> This guide covers importing JSON data sets. If you work with other data formats such as csv, you might want to look into conversion tools to JSON.

> This example uses modified JSON from the [Open Movie Database](https://www.omdbapi.com/).

The simplest use case for importing data is a list of items with the same structure. If you want to import data that includes nested JSON objects instead, check out the [guide for importing advanced data](!alias-aing2chaih).

All code and data in this example can be found in the [repository on GitHub](https://github.com/graphcool-examples/node-import-movies-example/tree/master/simple).

## 1. Preparing the data

Depending on your use case, you should make sure that your data is consistent and complete before importing it. For example, if you absolutely require that all your data items contain a value for a certain field, you should verify that before importing the data.

> Don't forget that fields in Graphcool can have a default value which can be of great help when importing data with missing values.

In this example, we want to import a list of movies stored in `movies.json`:

```json
[
  {
    "id": "tt0068646",
    "description": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
    "released": "24 Mar 1972",
    "title": "The Godfather"
  },
  {
    "id": "tt0071562",
    "description": "The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on his crime syndicate stretching from Lake Tahoe, Nevada to pre-revolution 1958 Cuba.",
    "released": "20 Dec 1974",
    "title": "The Godfather: Part II"
  },
  // some more movies
]

```

The data here is already ready to be imported, so we can think about the data schema for our Graphcool project next.

## 2. Preparing your project

Before actually importing the data, we have to setup the correct data schema for our project. First, let's create a new Graphcool project. In this example, all we need to do is create the `Movie` type. To determine its fields, we have to look at our existing data. As we can see above, a movie has the fields `id`, `description`, `released` and `title`.

For the `id` field in our data, you have to think about if you need to keep the old ids or not. In our case, let's just store them in the `oldId` field of type String with the `unique` constraint. That leaves us with the `description` and `title` fields of type String and the `released` field of type DateTime which you should create now as well.

## 3. Resetting project data

Importing data sets that may contain inconsistent or duplicate data can be error-prone at times.
If there is an error halfway through your import script, your project probably has inconsistent data. A clean approach in this case is to reset the project data in the project settings. While this does delete all the data in your project, your data schema and all project settings are preserved, allowing you to quickly restart the import process all over again.

## 4. Importing the data

To import your data, you can choose your favorite programming language. All you need to be able to do is to send HTTP POST requests to your Graphcool endpoint. In this example, we are using JavaScript for Node 7 and the GraphQL client [Lokka](https://github.com/kadirahq/lokka) to send mutations to our Graphcool project.

In our main method, we are first importing the raw movie data from `movies.json` and call the asynchronous `createMovies` method afterwards.
To actually run the script, we are then calling the main method and catch any upcoming error:

```js
const main = async() => {
  const rawMovies = require('./movies.json')

  // create movies
  const movieIds = await createMovies(rawMovies)
  console.log(`Created ${movieIds.length} movies`)
}

main().catch((e) => console.error(e))
```

Note that the main method has to be declared `async` allowing us to use `await`. To execute the script, we have to call `node --harmony-async-await import-movies.js`.

The `createMovies` method asynchronously calls the `createMovie` method for every movie in our data set:

```js
const createMovies = async(rawMovies) => {
  return await Promise.all(rawMovies.map(createMovie))
}
```

We initialize the Lokka client at the top of our script:

```js
const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__')
})
```

When we actually call the mutation to create a given movie in `createMovie`, the real action happens:

```js
const createMovie = async(movie) => {
  const result = await client.mutate(`{
    movie: createMovie(
      oldId: "${movie.id}"
      description: "${movie.description}"
      released: "${convertToDateTimeString(movie.released)}"
      title: "${movie.title}"
    ) {
      id
    }
  }`)

  return result.movie.id
}
```

Here we use the `mutate` method of the Lokka `client` to execute the `createMovie` mutation. Specifying the arguments `oldId`, `description` and `title` is straight-forward, we just have to wrap the values with double quotes. However, for the `released` argument which relates to a field of type DateTime, we have to format the raw string to the ISO 8601 format first. We do that by calling the `convertToDateTimeString` method on `movie.released`, where we use JavaScript's `Date.parse` and `toISOString` to handle the correct formatting:

```js
// convert to ISO 8601 format
const convertToDateTimeString = (str) => new Date(Date.parse(str)).toISOString()
```

Another crucial thing to make date time formatting work correctly is setting the local time zone of the Node process to `UTC`:

```js
// set timezone to UTC (needed for Graphcool)
process.env.TZ = 'UTC'
```

If you want to know more about working with dates and times, check the [guide on managing date and time values](!alias-ier7sa3eep).

## 5. Next steps

Nice, you learned how to prepare your Graphcool project and execute a simple import script. If you want to import data that includes nested JSON objects instead, check out the [guide for importing advanced data](!alias-aing2chaih). If you want to run the code yourself, find instructions in the [repository on GitHub](https://github.com/graphcool-examples/node-import-movies-example/tree/master/simple).
