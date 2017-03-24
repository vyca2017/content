---
alias: tioghei9go
path: /blog/connections-edges-nodes-relay
layout: BLOG
shorttitle: Connections, Edges & Nodes
description: Relay introduces new concepts on top of GraphQL. Learn more about terms like connections, edges and nodes in Relay and see a pagination example.
preview: movies-actors.png
publication_date: '2016-05-26'
tags:
  - relay
  - edges
  - nodes
  - pagination
related:
  further:
    - aizoong9ah
    - uo6uv0ecoh
    - thaiph8ung
  more:
    - chietu0ahn
    - voht5ach9i
    - ahsoow1ool
---

# Connections, Edges & Nodes in Relay

The terminology of Relay can be quite overwhelming in the beginning. Relay introduces a handful of new concepts on top of GraphQL, mainly in order to manage relationships between models.

This already leads to the first new term: a one-to-many relationship between two
models is called a **connection**.

### Example

Let's consider this following simple GraphQL query. It fetches the `releaseDate`
of the movie "Inception" and the names of all of its actors. The `actors` field is
a connection between a movie and multiple actors.

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
{
  Movie(title: "Inception") {
    releaseDate
    actors {
      name
    }
  }
}
---
{
  "data": {
    "Movie": {
      "releaseDate": "2010-08-28T20:00:00.000Z",
      "actors": [
        {
          "name": "Leonardo DiCaprio"
        },
        {
          "name": "Ellen Page"
        },
        {
          "name": "Tom Hardy"
        },
        {
          "name": "Joseph Gordon-Levitt"
        },
        {
          "name": "Marion Cotillard"
        }
      ]
    }
  }
}
```

Now let's take this query and adjust it to the expected format of Relay.

```graphql
---
endpoint: https://api.graph.cool/relay/v1/cixos23120m0n0173veiiwrjr
disabled: true
---
{
  viewer {
    Movie(title: "Inception") {
      releaseDate
      actors(first: 2) {
        edges {
          node {
            name
          }
        }
      }
    }
  }
}
---
{
  "data": {
    "viewer": {
      "Movie": {
        "releaseDate": "2010-08-29T00:00:00.000Z",
        "actors": {
          "edges": [
            {
              "node": {
                "name": "Leonardo DiCaprio"
              }
            },
            {
              "node": {
                "name": "Ellen Page"
              }
            }
          ]
        }
      }
    }
  }
}
```

### Edges and nodes

Okay, let's see what's going on here. The `actors` connection now has a more
complex structure containing the fields edges and node. These terms should be a
bit more clear when looking at the following image.

![](./movies-actors.png?width=559)

Don't worry. In order to use Relay, you don't have to understand the reasons why
the structure is designed this way but rest assured that [it makes a lot of
sense](https://facebook.github.io/relay/graphql/connections.htm).

Lastly, we also notice the `first: 2` parameter on the actors field. This gives
us a way to [paginate](!alias-riekooth4o) over the entire
list of related actors. In this case we're taking the first 10 actors (nodes).
In the same way we could additionally specify the `after` parameter which allows
us to skip a certain amount of nodes.

### Further reading

This was just a brief overview on connections in Relay. If you want to dive
deeper please check out the [Relay docs on
connections](https://facebook.github.io/relay/docs/graphql-connections.html) or
explore the [Relay Cursor Connections
Specification](https://facebook.github.io/relay/graphql/connections.htm).
