---
alias: aigheequ7j
path: /docs/faq/simple-api-cheatsheet
layout: FAQ
description: All the capabilities of the Simple API collected in a compact cheatsheet.
tags:
  - platform
  - simple-api
  - clients
related:
  further:
    - heshoov3ai
    - koo4eevun4
  more:
    - aing7uech3
    - ahfah0joo1
---

# Simple API Cheatsheet

# Schema

```graphql
type Author {
  id: ID!
  name: String! # required argument
  age: Int # optional argument
  posts: [Post!] @relation(name: "AuthorPosts")
  location: Location @relation(name: "AuthorLocation")
  follows: [Author!] @relation(name: "AuthorFollowers")
  followedBy: [Author!] @relation(name: "AuthorFollowers")
}

type Location {
  id: ID!
  city: String!
  author: Author @relation(name: "AuthorLocation")
}

type Post {
  id: ID!
  slug: String! # unique, required argument
  text: String!
  author: Author @relation(name: "AuthorPosts")
}
```

# Queries

## Fetch Scalar Values

```graphql
query allPosts {
  allPosts {
    id
    text
  }
}
```

## Fetch Related Nodes

```graphql
query allPosts {
  allPosts {
    id
    text
    author {
      id
      name
    }
  }
}
```

## Order by Scalar Value

```graphql
query orderPostsBySlug {
  ascending: allPosts(orderBy: slug_ASC) {
    id
    text
  }
  descending: allPosts(orderBy: slug_DESC) {
    id
    text
  }
}
```

## Filter by Scalar Values

```graphql
query filterPostsBySlug($slug: String!) {
  allPosts(filter: {
    slug: $slugStart
  }) {
    id
    text
  }
}
```

## Filter by To-One Relation

```graphql
query filterPostsByAuthorName($authorName: String!) {
  allPosts(filter: {
    author: {
      name: $authorName
    }
  }) {
    id
    text
  }
}
```

## Filter by To-Many Relation

```graphql
query filterAuthorsByPostSlug($slug: String!) {
  # only return authors who have no post with slug $slug
  none: allAuthors(filter: {
    posts_none: {
      slug: $slug
    }
  }) {
    id
    name
  }

  # only return authors who have at least one post with slug $slug
  some: allAuthors(filter: {
    posts_some: {
      slug: $slug
    }
  }) {
    id
    name
  }

  # only return authors who have only posts with slug $slug
  every: allAuthors(filter: {
    posts_every: {
      slug: $slug
    }
  }) {
    id
    name
  }
}
```

## Combine Filters

```graphql
query filterPostsBySlugAndAuthorName($slug: String!, $authorName: String!) {
  # only return posts with matching slug and author name
  and: allPosts(filter: {
    AND: [{
      slug: $slugStart
    }, {
      author: {
        name: $authorName
      }
    }]
  }) {
    id
    text
  }

  # return posts with matching slug or matching author name
  or: allPosts(filter: {
    OR: [{
      slug_starts_with: $slugStart
    }, {
      author: {
        name: $authorName
      }
    }]
  }) {
    id
    text
  }
}
```

```graphql
query filterPostsBySlugAndAuthorName($slugStar: String!, $authorName: String!) {
  allPosts(filter: {
    AND: [{
      slug_starts_with: $slugStart
    }, {
      author: {
        name: $authorName
      }
    }]
  }) {
    id
    text
  }
}
```

## Paginate Forward

```graphql
query forwardPaginationPosts($first: Int!, $after: String!) {
  allPosts(
    first: $first
    after: $after
  ) {
    id
    text
  }
}
```

## Paginate Backward

```graphql
query backwardPaginationPosts($last: Int!, $before: String!) {
  allPosts(
    last: $last
    before: $before
  ) {
    id
    text
  }
}
```

## Fetch by Unique Argument

```graphql
query specificPost($id: ID!, $slug: String!) {
  byId: Post(id: $id) {
    id
    author {
      id
    }
  }
  byUniqueArgument: Post(slug: $slug) {
    id
    author {
      id
    }
  }
}
```

## Fetch Aggregation Metadata

```graphql
query metaPost {
  _allPostsMeta {
    count
  }
}
```

# Mutations

## Create Node

```graphql
mutation createPost($text: String!, $slug: String!) {
  createPost(text: $text, slug: $slug) {
    id
  }
}
```

```graphql
mutation createAuthor($name: String!, $age: Int) {
  withAge: createAuthor(name: $name, age: $a) {
    id
  }

  withoutAge: createAuthor(name: $name) {
    id
  }
}
```

## Update Node

```graphql
mutation updatePost(id: ID!, $slug: String!) {
  updatePost(id: $id, slug: $slug) {
    id
  }
}
```

## Delete Node

```graphql
mutation deletePost(id: ID!) {
  deletePost(id: $id) {
    id
  }
}
```

## Connect nodes in a One-To-One Relation

```graphql
mutation connectAuthorAndLocation($authorId: ID!, $locationId: ID!) {
  setAuthorLocation(authorAuthorId: $authorId, locationLocationId: $locationId) {
    authorAuthor {
      id
    }
    locationLocation {
      id
    }
  }
}
```

## Disconnect nodes in a One-To-One Relation

```graphql
mutation connectAuthorAndLocation($authorId: ID!, $locationId: ID!) {
  unsetAuthorLocation(authorAuthorId: $authorId, locationLocationId: $locationId) {
    authorAuthor {
      id
    }
    locationLocation {
      id
    }
  }
}
```

## Connect nodes in a One-To-Many Relation

```graphql
mutation connectAuthorAndPost($authorId: ID!, $postId: ID!) {
  addToAuthorPosts(authorAuthorId: $authorId, postsPostId: $postId) {
    authorAuthor {
      id
    }
    postsPost {
      id
    }
  }
}
```

## Disconnect nodes in a One-To-Many Relation

```graphql
mutation disconnectAuthorAndPost($authorId: ID!, $postId: ID!) {
  removeFromAuthorPosts(authorAuthorId: $authorId, postsPostId: $postId) {
    authorAuthor {
      id
    }
    postsPost {
      id
    }
  }
}
```

## Connect nodes in a Many-To-Many Relation

```graphql
mutation connectAuthorAndAuthor($followesId: ID!, $followedById: ID!) {
  addToAuthorFollowers(followesAuthorId: $followesId, followedByAuthorId: $followedById) {
    followesAuthor {
      id
    }
    followedByAuthor {
      id
    }
  }
}
```

## Disconnect nodes in a Many-To-Many Relation

```graphql
mutation disconnectAuthorAndAuthor($followesId: ID!, $followedById: ID!) {
  removeFromAuthorFollowers(followesAuthorId: $followesId, followedByAuthorId: $followedById) {
    followesAuthor {
      id
    }
    followedByAuthor {
      id
    }
  }
}
```

## Shortcuts For To-Many Relations with Nested Mutations

* createAuthor
* createPost
* addToAuthorPosts

```graphql
mutation createAuthorAndPost($name: String, $text: String!, $slug: String!) {
  createAuthor(
    name: $name
    posts: [{
      text: $text
      slug: $slug
    }]
  ) {
    id
  }
}
```

* removeFromAuthorPosts - disconnect all posts from author node
* updateAuthor
* createPost
* addToAuthorPosts

```graphql
mutation updateAuthorAndCreatePost($id: ID!, $name: String, $text: String!, $slug: String!) {
  # This will overwrite all current posts assigned to the author!
  updateAuthor(
    id: $id
    name: $name
    posts: [{
      text: $text
      slug: $slug
    }]
  ) {
    id
  }
}
```

## Shortcuts For To-One Relations with Nested Mutations

* createAuthor
* createLocation
* setAuthorLocation

```graphql
mutation createAuthorAndLocation($name: String, $city: String!) {
  createAuthor(
    name: $name
    location: {
      city: $city
    }
  ) {
    id
  }
}
```

* updateAuthor
* createLocation
* setAuthorLocation

```graphql
mutation updateAuthorAndCreateLocation($id: ID!, $name: String, $city: String!) {
  # This will overwrite a current location assigned to the author!
  updateAuthor(
    id: $id
    name: $name
    location: {
      city: $city
    }
  ) {
    id
  }
}
```

## Nested Create Mutations for To-Many Relations

```graphql
mutation createAuthorAndPost($name: String, $text: String!, $slug: String!) {
  createAuthor(
    name: $name
    posts: [{
      text: $text
      slug: $slug
    }]
  ) {
    id
  }
}
```

```graphql
mutation updateAuthorAndCreatePost($id: ID!, $name: String, $text: String!, $slug: String!) {
  # This will overwrite all current posts assigned to the author!
  updateAuthor(
    id: $id
    name: $name
    posts: [{
      text: $text
      slug: $slug
    }]
  ) {
    id
  }
}
```
