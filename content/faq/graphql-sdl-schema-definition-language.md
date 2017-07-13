---
alias: kr84dktnp0
path: /docs/faq/graphql-sdl-schema-definition-language
layout: FAQ
description: GraphQL SDL is the syntax to specify a GraphQL schema through type definitions, enums, interfaces and other concepts.
preview: ./graphql-idl-schema-definition-language.png
tags:
  - graphql
  - data-schema
related:
  further:
    - ahwoh2fohj
    - teizeit5se
    - ij2choozae
  more:
    - moach1gich
    - jor2ohy6uu
---

# GraphQL SDL - Schema Definition Language

## What is a GraphQL Schema Definition?

A GraphQL Schema Definition is the most concise way to specify a GraphQL schema. The syntax is well-defined and [will be adopted in the official GraphQL Spec](https://github.com/facebook/graphql/pull/90). Schema Definitions are sometimes referred to as IDL (Interface Definition Language) or SDL (Schema Definition Language).

The GraphQL schema for a blog app could be specified like this:

```graphql
type Post {
  id: String!
  title: String!
  publishedAt: DateTime!
  likes: Int! @default(value: 0)
  blog: Blog @relation(name: "Posts")
}

type Blog {
  id: String!
  name: String!
  description: String,
  posts: [Post!]! @relation(name: "Posts")
}
```

The main components of a Schema Definition are the types and their fields. Additional information can be provided as custom directives like the `@default` value specified for the likes field.

### Type

A type has a name and can extend one or more interfaces:

```graphql
type Post implements Item {
  # ...
}
```

### Field

A field has a name and a type:

```graphql
name: String
```

The GraphQL spec defines some [built-in](https://facebook.github.io/graphql/#sec-Scalars) scalar values but more can be defined by a concrete implementation. The built in scalar types are:

 - Int
 - Float
 - String
 - Boolean
 - ID

In addition to scalar types, a field can use any other type defined in the Schema Definition.

non-nullable fields are denoted by an exclamation mark:

```graphql
name: String!
```

lists are denoted by square brackets:

```graphql
names: [String!]
```

### Enum

An enum is a scalar value that has a specified set of possible values:

```graphql
enum Category {
  PROGRAMMING_LANGUAGES,
  API_DESIGN
}
```

### Interface

In GraphQL an interface is a list of fields. A GraphQL type must have the same fields as all the interfaces it implements and all interface fields must be of the same type.

```graphql
interface Item {
  title: String!
}
```

### Schema directive

A directive allows you to attach arbitrary information to any other Schema Definition element. Directives are always placed behind the element they describe:

```graphql
name: String! @defaultValue(value: "new blogpost")
```
Directives don't have intrinsic meaning. Each GraphQL implementation can define their own custom directives that add new functionality.

GraphQL specifies built-in `skip` and `include` directives that can be used to include or exclude specific fields in queries, but these aren't used in the schema language.
