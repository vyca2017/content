# Error Handling in the Request Pipeline

## Provoking an error to abort a request

You can intercept the further processing of an incoming request by returning an object that contains an `error` property.

### Returning error strings

The function returns a string error:

```js
({data, context}) => {
  return {
    error: "Invalid email!"
  }
}
```

In this case we return:

```json
{
  "data": null,
  "errors": [
    {
      "code": 5001,
      "message": "Function execution error: 'Invalid email!'",
      "functionError": "Invalid email!"
    }
  ]
}
```

### Returning error objects

The function returns a json error object:

```js
{data, context}) => {
    if (!isValidEmail) {
        return {
          error: {
            code: 42,
            message: "Invalid email!",
            debugMessage: "We should add validation in the frontend as well!"
          }
        }
    }
}
```

In this case we return:

```json
{
  "data": null,
  "errors": [
    {
      "code": 5002,
      "message": "Function execution error",
      "functionError": {
        "error": {
          "code": 42,
          "message": "Invalid email!",
          "debugMessage": "We should add validation in the frontend as well!"
        }
      }
    }
  ]
}
```

## Unexpected errors

The function failed in a way the developer did not anticipate (it returns a 4xx or 5xx status code.) In this case we return:

```json
{
  "data": null,
  "errors": [
    {
      "code": 5000,
      "message": "A function returned an unhandled error. Please check the logs for executionId 'cj27leckw31to0153whdva5b2'"
    }
  ]
}
```
