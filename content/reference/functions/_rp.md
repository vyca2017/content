Functions give you the possibility to define custom business logic. Are a simple yet powerful concept to handle your custom business logic workflow without the need to host and maintain your own infrastructure

And the error handling:
There are two cases:

1) The function failed in a way the developer did not anticipate (it returns a 4xx or 5xx status code.) In this case we return:

```{
    data: null,
    errors: [
    {
        code: 5000,
        message: "A function returned an unhandled error. Please check the logs for executionId 'cj27leckw31to0153whdva5b2'"
    }]
}
```

2) The function returns a specific error. In this case there are two sub cases:

2.a) The function returns a string error:

```({data, context}) => {
    if (!isValidEmail) {
        return {error: "invalid email"}
    }
}
```

In this case we return:

```{
    data: null,
    errors: [
    {
        code: 5001,
        message: "function execution error: invalid email"
        functionError: "invalid email"
    }]
}
```

2.b) The function returns a json error object:

```({data, context}) => {
    if (!isValidEmail) {
        return {error: {code: 1, message: "invalid email", debugMessage: "This user is a derp - just pretend like the email is invalid"}}
    }
}
```

In this case we return:

```{
    data: null,
    errors: [
    {
        code: 5002,
        message: "function execution error"
        functionError: {error: {code: 1, message: "invalid email", debugMessage: "This user is a derp - just pretend like the email is invalid"}}
    }]
}```
