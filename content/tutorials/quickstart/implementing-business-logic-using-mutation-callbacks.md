---
alias: saigai7cha
path: /docs/tutorials/quickstart-3
layout: TUTORIAL
preview: implementing-business-logic-using-mutation-callbacks.png
shorttitle: Implementing business logic
description: Add custom business logic to a GraphQL backend. In this guide, we will add a Mailgun integration to notify users of new comments to their posts.
tags:
  - functions
  - mutation-callbacks
  - webtask
  - mailgun
related:
  further:
    - ahlohd8ohn
  more:
    - daisheeb9x
    - dah6aifoce
---

# Implementing Business Logic using Mutation Callbacks

<iframe height="315" src="https://www.youtube.com/embed/b_Nh5dkDaKg" frameborder="0" allowfullscreen></iframe>

In this guide you will learn how you can enhance your GraphQL backend with a custom business logic workflow.

> If you want to follow along, make sure to finish the [previous guide](!alias-thaeghi8ro) on how to set up a GraphQL backend in less than 5 minutes.

We will expand the Instagram clone from the previous guide by associating posts and comments with a specific user so we can send users a notification email as soon as someone adds a comment to one of their posts.

## 1. Preparation

Let's create an example user to see the notification emails in action. Go to the `User` model and add a new node. To verify later that notification emails are being sent correctly, enter your own name and email. Now navigate to the `Post` model and set the `author` field of all the post nodes to the user you just created.

Optionally, create as many other users that you want. They can be used as the author of comments in a later section.

## 2. Creating an Mutation Callback Handler

You can use services like [AWS Lambda](https://aws.amazon.com/de/lambda/getting-started/) or [webtask](https://webtask.io/) to create an mutation callback handler that executes a certain part of your business logic whenever triggered.

For this guide we will use webtask where we use Mailgun to send out notification emails.

> This is just one of the many use cases you can solve with mutation callbacks. If you have an advanced requirement, AWS Lambda might be the better choice as it is more powerful than webtask.

### 2.1 Setting up Mailgun

Sign up at [Mailgun](https://mailgun.com) and get your Mailgun API Base URL and secret Mailgun API key for later use.
The URL starts with `https://api.mailgun.net/v3/` and the API key starts with `key-`. Both can be found at your Mailgun domain overview.
We have to append `/messages` to the URL so we can use it from within the webtask.

### 2.2 Cloning the example code

Clone the [webtask example repository](https://github.com/graphcool-examples/webtask-mailgun-email-example) and open the file `notifications.js`. Let's examine this file together.

When the webtask is triggered, `context.data` will contain the payload for the mutation callback. We will see in the next how to control the payload, but in our example `createdNode` contains all the information we need for the notification email.

```javascript
const comment = context.data.createdNode
```

Then we are using the information stored in `createdNode` to create local variables for the text elements we need in our notification email:

```javascript
  const recipient = comment.post.author

  const from = 'Instacat Notification Service <notifications@instacat.net>'
  const to = `${recipient.name} <${recipient.email}>`
  const subject = `A New Instacat Notification for ${recipient.name}`
  const text = `Hey ${recipient.name}, ${comment.author.name} just posted this comment: ${comment.text}`
```

Finally, we are actually sending an email by using the Mailgun url and authorize it with the Mailgun API key:

```javascript
 request.post(MAILGUN_URL)
  .auth('api', MAILGUN_API_KEY)
  .form( { from: from,
           to: to,
           subject: subject,
           text: text
  }).on('error', function(err) {
    console.log('Error sending mail ' + err.toString())
    res.end('Error sending mail')
  }).on('response', function(response) {
    console.log('Response ' + JSON.stringify(response))
    res.end()
  })
```

## 2.3 Setting up Webtask

Sign up at [webtask](https://webtask.io/) and download the webtask cli with

```sh
npm install wt-cli -g
```

Create a new webtask with
```sh
wt create notifications.js -s MAILGUN_URL=YOUR_URL -s MAILGUN_API_KEY=YOUR_SECRET_KEY --parse-body
```

Remember that your `MAILGUN_URL` looks something like `https://api.mailgun.net/v3/<unique-id>.mailgun.org/messages` and your secret `MAILGUN_API_KEY` starts with `key-`.
Copy the webtask URL and keep it ready for the next step.

> Also check out [the official documentation](https://webtask.io/docs/101) on getting started with webtask.

## 3. Creating a new Mutation Callback

Now that we have setup our mutation callback handler, we are ready to configure an associated mutation callback. Mutation callbacks define *when* the handler is triggered and *what* data payload the handler will receive. This way we can automatically send notification emails when a new comment is posted and include the necessary information to formulate the email in the payload for the mutation callback. To do that, go to the mutation callbacks page and click "Create Mutation Callback".

Here we have the possibility to configure the trigger and the payload for the mutation callback and enter a URL that points to the handler we just created.

For the trigger, select the `Comment` model and the `is created` mutation, so the mutation callback is triggered whenever a comment is created.

The payload is the information the handler needs to complete the mutation callback. In our case, we are interested in the actual comment, its author and the author of the post the comment is related to. We can express this by selecting fields on the exposed `createdNode`:

```graphql
{
  createdNode {
    text
    author {
      name
    }
    post {
      author {
        name
        email
      }
    }
  }
}
```

As the last step, we have to enter the URL to our handler and confirm to create the mutation callback.

## 4. Triggering an Mutation Callback

To trigger the mutation callback that sends notification emails, we should add a few comments. Navigate to the `Comment` model and create some comments setting one of the users we created before as author. You should get a new email after a few moments. Alternatively you can run
```
wt logs
```
to read the logs of the webtask.

## 5. Next Steps

Congratulations, you just implemented an email notification system for your Instagram clone in a few minutes!

Explore the reference documentation to find out more about concepts like [authentication](!alias-wejileech9), [permissions](!alias-iegoo0heez) and [file management](!alias-eer4wiang0) or continue with the [next guide on thinking in terms of graphs](!alias-ahsoow1ool).
