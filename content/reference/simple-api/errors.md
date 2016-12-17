---
alias: aecou7haj9
path: /docs/reference/simple-api/error-management
layout: REFERENCE
shorttitle: Error management
description: Query or mutation errors in GraphQL are handled as part of the query response, where you can find further information to solve them.
simple_relay_twin: looxoo7avo
tags:
  - simple-api
  - errors
related:
  further:
    - wejileech9
    - iegoo0heez
    - eer4wiang0
---

# Error management in the Simple API

When an error occurs for one of your queries or mutations, the `data` field of the query response will usually be `null` and the error `code`, the error `message` and further information will be included in the `errors` field of the response JSON.

## API Errors

An error returned by the API usually indicates that something is not correct with the query or mutation you are trying to send from your client application to the API endpoint.

Try to investigate your input for possible errors related to the error message.

Maybe the syntax of a request is not correct, or you forgot to include a required query argument?
Another possibility is that the supplied data could not be found on our servers, so check any provided id if it points to an existing node.

Here is an overview of possible errors that you might encounter:

**Code 3000: GraphQLArgumentsException**

**Code 3001: IdIsInvalid**

**Code 3002: DataItemDoesNotExist**

**Code 3003: IdIsMissing**

**Code 3004: DataItemAlreadyExists**

**Code 3005: ExtraArguments**

**Code 3006: InvalidValue**

**Code 3007: ValueTooLong**

**Code 3008: InsufficientPermissions**

**Code 3009: RelationAlreadyFull**

**Code 3010: UniqueConstraintViolation**

**Code 3011: NodeDoesNotExist**

**Code 3012: ItemAlreadyInRelation**

**Code 3013: NodeNotFoundError**

**Code 3014: InvalidConnectionArguments**

**Code 3015: InvalidToken**

**Code 3016: ProjectNotFound**

**Code 3018: InvalidSigninData**

**Code 3019: ReadonlyField**

**Code 3020: FieldCannotBeNull**

**Code 3021: CannotCreateUserWhenSignedIn**

**Code 3022: CannotSignInCredentialsInvalid**

**Code 3023: CannotSignUpUserWithCredentialsExist**

**Code 3024: VariablesParsingError**

**Code 3025: Auth0IdTokenIsInvalid**

> For example, when you try to update a post but specify a non-existing id:

```graphql
---
endpoint: https://api.graph.cool/simple/v1/cixne4sn40c7m0122h8fabni1
disabled: true
---
mutation {
  updatePost(
    id: "wrong-id",
    title: "My new Title"
  ) {
    id
  }
}
---
{
  "data": {
    "updatePost": null
  },
  "errors": [
    {
      "locations": [
        {
          "line": 21,
          "column": 3
        }
      ],
      "path": [
        "updatePost"
      ],
      "code": 3002,
      "message": "'Post' has no item with id 'wrong-id'",
      "requestId": "cixnho5zctixo0143pjqwaqry"
    }
  ]
}
```

**Internal Server Errors**

*Internal server errors* indicate that something went wrong with our service - whoops! Find us at our [Slack channel](http://slack.graph.cool) so we can help you out and fix the issue.

You do not have to investigate this issue further in your client application.
