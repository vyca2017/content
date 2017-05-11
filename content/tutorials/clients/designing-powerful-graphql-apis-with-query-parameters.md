---
alias: aing7uech3
path: /docs/tutorials/designing-powerful-apis-with-graphql-query-parameters
layout: TUTORIAL
shorttitle: Designing Powerful GraphQL APIs
description: GraphQL queries provide an efficient way to fetch data. Our GraphQL API leverages different GraphQL query arguments to provide even more control.
preview: query-parameter.png
tags:
  - platform
  - queries
  - client-apis
  - query-arguments
  - filters
  - order-by
  - pagination
related:
  further:
    - nia9nushae
    - pa2aothaec
    - ua6eer7shu
  more:
    - vietahx7ih
    - ul6ue9gait
    - cahzai2eur
---

# Designing Powerful APIs with GraphQL Query Parameters

GraphQL queries provide an efficient way to fetch data, even across multiple types. This results in a great abstraction layer on top of databases, but sometimes more is needed to satify specific data requirements of modern applications.

Our GraphQL API **puts the client in control of the data** and provides **the best possible developer experience (DX)** by exposing different query arguments. Similar to our [nested mutations syntax](!alias-vietahx7ih) which sees adoption by more and more companies, we at Graphcool are happy to share our best practices designing powerful GraphQL APIs with the GraphQL community.

This tutorial explores some of the capabilities of our GraphQL APIs including:

* **Filters**: Filters nodes by applying one or many matching rules.
* **Sorting**: Orders the set of results ascending or descending by a field.
* **Pagination**: Groups nodes in different pages that can be seeked, either forwards or backwards.

## Filters reduce client complexity

Often you are interested to query specific parts of your data. In a movie database for example, you might search movies that are released after a certain date or have a specific title. While you can always query all movies and filter them client side, this would result in unnecessary data - something that GraphQL is set out to avoid.

This is a great use case for GraphQL [query arguments](https://facebook.github.io/graphql/#sec-Language.Arguments)! By adding a `filter` parameter to a query, the above scenario can quickly be solved. If you are interested in movies with the title "The Dark Knight", you only have to specify the `title` field on `filters`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
---
query darkKnightMovie {
  allMovies(filter: {
    title: "The Dark Knight"
  }) {
    releaseDate
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "releaseDate": "2008-07-18T00:00:00.000Z"
      }
    ]
  }
}
```

Filtering by title works great for fetching single movies. In fact, the filter system is much more powerful than that, as it is encoding a [boolean algebra](https://en.wikipedia.org/wiki/Boolean_algebra#Boolean_algebras). This allows a great level of expressiveness based on logical operators.

You can combine filter conditions using the `OR` and `AND` operators to select multiple movies you are interested in. For example, if you are interested in the movie "Inception" and additionally in movies released after 2009 that have a title starting with "The Dark Knight", you can combine the two conditions with `OR`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
---
query combineMovies {
  allMovies(filter: {
    OR: [{
      AND: [{
        releaseDate_gte: "2009"
      }, {
        title_starts_with: "The Dark Knight"
      }]
    }, {
      title: "Inception"
    }]
  }) {
    title
    releaseDate
  }
}
---
{
  "data": {
    "allMovies": [
      {
        "title": "Inception",
        "releaseDate": "2010-08-28T20:00:00.000Z"
      },
      {
        "title": "The Dark Knight Rises",
        "releaseDate": "2012-07-20T00:00:00.000Z"
      }
    ]
  }
}
```

By providing the `filter` query argument, **the server is doing the heavy lifting while the client stays in full control** over its data requirements. This results in a clear and expressive API and separates concerns between the frontend and the backend.

## Expressing even complex data requirements

Another typical requirement is sorting data - again something that is better handled by the server than the client. Let's combine sorting data with filters!

This time we're interested in actors that appeared in movies released since 2009. The `filter` argument is a powerful system for requests like that. We can use `movies_some` with a nested `releaseDate_gte: "2009"`, meaning that we are only interested in actors where *some* of their movies fulfill the nested conditions.

On top of that, we are sorting the actors ascending by name with `orderBy: name_ASC`:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
---
query actorsAfter2009 {
  allActors(
    filter: {
      movies_some: {
        releaseDate_gte: "2009"
      }
    }
    first: 3
    orderBy: name_ASC
  ) {
    name
    movies {
      title
    }
  }
}
---
{
  "data": {
    "allActors": [
      {
        "name": "Anne Hathaway",
        "movies": [
          {
            "title": "The Dark Knight Rises"
          }
        ]
      },
      {
        "name": "Christian Bale",
        "movies": [
          {
            "title": "The Dark Knight"
          },
          {
            "title": "Batman Begins"
          },
          {
            "title": "The Dark Knight Rises"
          }
        ]
      },
      {
        "name": "Ellen Page",
        "movies": [
          {
            "title": "Inception"
          }
        ]
      }
    ]
  }
}
```

Combining filter and order parameters like that allows you to easily express even complex data requirements. We could also use `movies_none` or `movies_all` to express that *no* or *all* movies of an actor fulfill certain conditions.

If you look closely, you can also find the `first: 3` argument in the above query. Let's see what this is about.

## Browsing data in equally sized pages

Imagine a website that lists movies and their actors. Your data might contain thousands of movies each with dozens of actors. A typical scenario is then to only display a few movies at the same time, allowing the user to seek forwards and backwards through the whole list.

What you can do instead of fetching all movies at once in this case is to mirror the representation parameters in your query and only fetch the data you currently need. Again, this simplifies the needed client logic a lot while also reducing transmitted data. This approach is called *offset-based pagination*. An even more advanced pagination variant is the *cursor-based pagination* that is also available by combining `first` with `after` or `last` with `before`. Here we are focusing on offset-based pagination though.

The **pagination arguments integrate seamlessly with filtering and ordering**. This way, we end up with a simple query that fulfills a very complex request. Let's have a look at how we can apply all what we've learned so far in the following query. We display the first two movies that are released since 2000, order them by their release date and sort their actors by name. But see for yourself:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
---
query paginateMoviesAndActors($movieFirst: Int, $movieSkip: Int, $actorFirst: Int, $actorSkip: Int, $movieOrder: MovieOrderBy) {
  allMovies (
    filter: {
      releaseDate_gt: "2000"
    }
    orderBy: $movieOrder
    first: $movieFirst
    skip: $movieSkip
  ) {
    title
    actors(
      orderBy: name_ASC,
      first: $actorFirst,
      skip: $actorSkip
    ) {
      name
    }
    releaseDate
  }
}
---
{
  "movieFirst": 2,
  "movieSkip": 0,
  "actorFirst": 3,
  "actorSkip": 0,
  "movieOrder": "releaseDate_ASC"
}
---
{
  "data": {
    "allMovies": [
      {
        "title": "Batman Begins",
        "actors": [
          {
            "name": "Christian Bale"
          },
          {
            "name": "Gary Oldman"
          },
          {
            "name": "Katie Holmes"
          }
        ],
        "releaseDate": "2005-06-15T00:00:00.000Z"
      },
      {
        "title": "The Dark Knight",
        "actors": [
          {
            "name": "Aaron Eckhart"
          },
          {
            "name": "Christian Bale"
          },
          {
            "name": "Gary Oldman"
          }
        ],
        "releaseDate": "2008-07-18T00:00:00.000Z"
      }
    ]
  }
}
```

You can experiment with the available query variables to see what effect they have. For example, you can change the `movieSkip` to `2` and `movieOrder` to `title_DESC` and run the query again. This returns the second page of movies sorted descending by title.

## Conclusion

Our carefully designed GraphQL APIs offer great flexibility and control for client applications. With different rules to [filter](!alias-xookaexai0), [sort](!alias-vequoog7hu) and [paginate](!alias-ojie8dohju) your data, you can exactly express the data you are interested in and let the backend figure out the rest.

Do you have any questions about our API? Join our [Slack channel](https://slack.graph.cool) to start a discussion or browse [the docs](https://graph.cool/docs) for more information. If you have no account yet, you can sign up at Graphcool [here](https://console.graph.cool/signup).
