# Migrating Fields

TODO
* Console
* CLI
* Field modifiers (required, unique, lists)
* enums
* defaultValue
* migrationValue

## Adding a new scalar field

TODO
* enums
* relation fields

You can add new fields to your GraphQL schema by including them in an existing type. This will modify existing [queries](), [mutations]() and [subscriptions]() in your GraphQL API.

Consider this schema file:

```graphql
type Story implements Node {
  id: ID!
  name: String!
}
```

Let's add a few fields to the `Story` type:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  description: String! @migrationValue(value: "No description yet")
  isPublished: Boolean @migrationValue(value: "true") @defaultValue(value: "false")
  length: Int
}
```

We added three fields `description: String!`, `isPublished: Boolean` and `length: Int`:

* as `description` is a required String, we need to supply the `@migrationValue(value: String)` directive to migrate existing `Story` nodes (assuming there are existing stories already).
* for the optional `isPublished` field of type Boolean, we don't have to supply a migration value, but we do so nonetheless. Additionally we set the default value to `false` using the `@defaultValue(value: String!)` directive.
* for the optional field `length`, we did not supply a migration or default value.

Because the directive `@migrationValue(value: String!)` is temporary, we receive an updated schema file after the migration was successful:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  description: String!
  isPublished: Boolean @defaultValue(value: "false")
  length: Int
}
```

Have a look at the [naming conventions for fields]() to see what names are allowed and recommended.

## Removing an existing field

To remove an existing field, you can delete the corresponding line in the schema file. This will remove **all data for this field**.

> Removing a field potentially breaks existing queries, mutations and subscriptions. Make sure to not rely on this field in your apps before deleting it.

Consider this schema file:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  isPublished: Boolean!
  description: String!
  isPublished: Boolean @defaultValue(value: "false")
  length: Int
}
```

Let's remove some of the fields of the `Story` type:

```graphql
type User implements Node {
  id: ID!
  name: String!
  isPublished: Boolean @defaultValue(value: "false")
}
```

## Renaming an existing field

Renaming a field can be done with the `@rename(oldName: String!)` directive.

> Renaming a field potentially breaks existing queries, mutations and subscriptions. Make sure to adjust your app accordingly to the new name.

Consider this schema file:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  isPublished: Boolean!
  description: String!
  isPublished: Boolean @defaultValue(value: "false")
  length: Int
}
```

To rename the `description` field to `information`, we use the [temporary directive]() `@rename(oldName: String!)` on the field itself:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  isPublished: Boolean!
  information: String! @rename(oldName: "description")
  isPublished: Boolean @defaultValue(value: "false")
  length: Int
}
```

After the successful rename operation, we obtain this new schema file:

```graphql
type Story implements Node {
  id: ID!
  name: String!
  isPublished: Boolean!
  information: String!
  isPublished: Boolean @defaultValue(value: "false")
  length: Int
}
```

Note that the temporary directive `@rename` is not in the schema file anymore.
