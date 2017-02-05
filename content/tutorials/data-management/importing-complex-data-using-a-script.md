---
alias: aing2chaih
path: /docs/tutorials/importing-complex-data
layout: TUTORIAL
preview: import-data-icon.png
description: Use a script to import nested JSON data to your GraphQL backend.
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
    - ofee7eseiy
    - zeich1raej
    - ahwoh2fohj
  more:
    - ga2ahnee2a
    - ier7sa3eep
    - eefoovo2ah
    - uu2xighaef
---

# Importing complex data using a script

Importing existing data to one of your Graphcool projects manually can be quite tedious. Depending on the amount of data you have, using an import script can be the better approach for this task. This is done in two steps. First, we prepare the data schema of the Graphcool project. Then we can run a script that populates the project with the existing data.

> This guide covers importing JSON data sets. If you work with other data formats such as csv, you might want to look into conversion tools to JSON.

> This example uses modified JSON from the [Open Movie Database](https://www.omdbapi.com/).

Importing nested JSON data can be handled by creating models and relations. If your data has a simpler structure, check out the [guide for importing simple data](!alias-ga2ahnee2a).

All code and data in this example can be found in the [repository on GitHub](https://github.com/graphcool-examples/node-import-movies-example/tree/master/advanced-javascript).

## 1. Preparing the data

Depending on your use case, you should make sure that your data is consistent and complete before importing it. For example, if you absolutely require that all your data items contain a value for a certain field, you should verify that before importing the data.

> Don't forget that fields in Graphcool can have a default value which can be of great help when importing data with missing values.

In this example, we want to import a list of movies with nested actors stored in `movies.json`:

```json
[
  {
    "id": "tt0068646",
    "actors": [
      {
        "id": "marlon-brando-id",
        "birthday": "3 Apr 1924",
        "gender": "male",
        "name": "Marlon Brando"
      },
      {
        "id": "al-pacino-id",
        "birthday": "25 Apr 1940",
        "gender": "male",
        "name": "Al Pacino"
      }
    ],
    "description": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
    "released": "24 Mar 1972",
    "title": "The Godfather"
  },
  {
    "id": "tt0071562",
    "actors": [
      {
        "id": "al-pacino-id",
        "birthday": "25 Apr 1940",
        "gender": "male",
        "name": "Al Pacino"
      },
      {
        "id": "robert-duvall-id",
        "birthday": "5 Jan 1931",
        "gender": "male",
        "name": "Robert Duvall"
      }
    ],
    "description": "The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on his crime syndicate stretching from Lake Tahoe, Nevada to pre-revolution 1958 Cuba.",
    "released": "20 Dec 1974",
    "title": "The Godfather: Part II"
  }
]
```

The data here is already ready to be imported, so we can think about the data schema for our Graphcool project next.

## 2. Preparing your project

Before actually importing the data, we have to setup the correct data schema for our project. First, let's create a new Graphcool project.

### 2.1 The `Movie` model

In your new project, create the `Movie` model. To determine its fields, we have to look at our existing data. As we can see above, a movie has the fields `id`, `description`, `released` and `title`.

For the `id` field in our data, you have to think about if you need to keep the old ids or not. In our case, let's just store them in the `oldId` field of type String with the `unique` constraint. That leaves us with the `description` and `title` fields of type String and the `released` field of type DateTime which you should create now as well.

### 2.2 The `Actor` model

Next create the `Actor` model. An actor is described by a `birthday` of type DateTime, a `name` and a `gender` of type String.

For the `id` in our data the same considerations as for the `Movie` model can be made, so let's just create an `oldId` field of type String as well.

### 2.3 The `ActorMovies` relation

A good rule of thumb is that we need a relation exactly for every nested field in our data. As actors and movies are related in our data, we want to reflect that in the Graphcool project as well. Let's create the `ActorMovies` relation, that relates many actors to many movies as one actor can appear in many movies while a movie can also contain many actors. We name the fields `actor` and `movies`.

## 3. Resetting project data

Importing data sets that may contain inconsistent or duplicate data can be error-prone at times.
If there is an error halfway through your import script, your project probably has inconsistent data. A clean approach in this case is to reset the project data in the project settings. While this does delete all the data in your project, your data schema and all project settings are preserved, allowing you to quickly restart the import process all over again.

## 4. Importing the data

To import your data, you can choose your favorite programming language. All you need to be able to do is to send HTTP POST requests to your Graphcool endpoint. In this example, we are using JavaScript for Node 7 and the GraphQL client [Lokka](https://github.com/kadirahq/lokka) to send mutations to our Graphcool project.

Our strategy to import all the data is as follows:

* set up the environment
* collect all actors in the data and discard duplicates
* add all actors to the Graphcool project and store a dictionary that maps old actor ids to the newly generated ones
* add all movies to the Graphcool project and store a dictionary that maps old movie ids to the newly generated ones
* using the id dictionaries, we now create (movieId, actorId) pairs of movies and actors and connect them via the `ActorMovies` relation

For type safety, we use TypeScript. In the GitHub repository, you'll also find a JavaScript version. We use multiple utility functions from the [lodash](https://lodash.com/) library as well.


### 4.1 Setting up the environment

At the top of the file, we are initializing Lokka to connect it to our Graphcool endpoint:

```js
const client = new Lokka({
  transport: new Transport('https://api.graph.cool/simple/v1/__PROJECT_ID__')
})
```

We are also setting the timezone of our environment to `UTC` so Date parsing behaves as expected:

```js
// set timezone to UTC (needed for Graphcool)
process.env.TZ = 'UTC'
```

If you want to know more about working with dates and times, check the [guide on managing date and time values](!alias-ier7sa3eep).

### 4.2 Collecting all actors

To collect all actors, we map over all movies in our data, flat map over their actors and discard duplicated by identifying unique actors by their id.

```js
const rawMovies = require('../movies.json')

const allActors = _.chain(rawMovies)
  .flatMap(rawMovie => rawMovie.actors)
  .uniqBy(actor => actor.id)
  .value()
```

### 4.3 Adding the actors to the project

Now we call `createActors` to create all collected actors:

```js
// create actors
const actorIdMap = await createActors(allActors)
console.log(`Created ${Object.keys(actorIdMap).length} actors`)
```

`createActors` asynchronously calls the `createActor` method on every passed actor, which returns the new actor id generated by Graphcool.
We zip the new and old ids to return a dictionary that maps new ids to old ones.

```js
const createActors = async (rawActors: Actor[]): Promise<IdMap> => {
  const actorIds = await Promise.all(rawActors.map(createActor))

  return _.zipObject<IdMap>(rawActors.map(actor => actor.id), actorIds)
}
```

The `createActor` method handles the actual `createActor` mutation that creates a new actor node in the Graphcool project and returns its new id:

```js
const createActor = async (actor: Actor): Promise<string> => {
  const result = await client.mutate(`{
    actor: createActor(
      oldId: "${actor.id}"
      birthday: "${convertToDateTimeString(actor.birthday)}"
      gender: "male"
      name: "${actor.name}"
    ) {
      id
    }
  }`)

  return result.actor.id
}
```

### 4.4 Adding the movies to the project

Next, we are creating the movies in our Graphcool project:

```js
// create movies
const movieIdMap = await createMovies(rawMovies)
console.log(`Created ${Object.keys(movieIdMap).length} movies`)
```

We also obtain a dictionary that maps new movie ids to old ones. This works similar as with actors, so let's go ahead and connect the movies and actors.

### 4.5 Connecting movies and actors

Let's have a look at the actual mutation that connects a movie with an actor first:

```js
const connectMoviesAndActorsMutation = (actorId: string, movieId: string): Promise<any> => (
  client.mutate(`{
    addToActorMovies(actorsActorId: "${actorId}" moviesMovieId: "${movieId}") {
      # we don't need this but we need to return something
      moviesMovie {
        id
      }
    }
  }`)
)
```

This method is quite straight-forward. Now all we have to do is generate the correct list of movie/actor id pairs that we then can use to connect them.

Let's first look at the complete code that manages that:

```js
// connect movies and actors
const mutations = _.chain(rawMovies)
  .flatMap((rawMovie) => {
    const newActorIds = rawMovie.actors.map((actor) => actorIdMap[actor.id])
    const newMovieId = movieIdMap[rawMovie.id]

    return newActorIds.map((newActorId) => ({newActorId, newMovieId}))
  })
  .map(({newActorId, newMovieId}) => connectMoviesAndActorsMutation(newActorId, newMovieId))
  .value()

await Promise.all(mutations)
console.log(`Created ${mutations.length} edges between actors and movies`)
```

We are flat mapping over every all the raw movies in our data set. For each movie, we create a list of actor ids that appeared in that movie. Then we map over those new actor sids and for each id we pair it with the new id of the according movie. Then all that we need to do is call the mutation that connects the movie with the actor and we are done.

## 5. Next steps

Nice, you learned how to prepare your Graphcool project and execute an import script for nested data. If you want to import simpler data structures, check out the [guide for importing simple data](!alias-ga2ahnee2a). If you want to run the code yourself, find instructions in the [repository on GitHub](https://github.com/graphcool-examples/node-import-movies-example/tree/master/advanced).

Scripts like these can add a lot of flexibility to your Graphcool project. For example, you can also execute an arbitrary script when a specific mutation occurs. If you are interested in mutation callbacks in general, the [guide about sending notification emails with mutation callbacks](!alias-saigai7cha) might be helpful.
