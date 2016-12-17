---
alias: vietahx7ih
path: /blog/improving-dx-with-nested-mutations
layout: BLOG
shorttitle: Nested mutations
description: Nested mutations make common workflows with our GraphQL APIs more efficient and improve developer experience. 
preview: nested-mutations-example.png
publication_date: '2016-10-07'
tags:
  - mutations
  - client-apis
related:
  further:
    - ol0yuoz6go
    - wooghee1za
    - goh5uthoc1
  more:
    - cahzai2eur
    - chietu0ahn
---

# Improving DX with nested mutations

We're excited to announce **nested mutations**! Creating two (or more) related
nodes and connecting them with an edge was more complicated than it needed to
be. By extending our API with nested mutations we are combining mutations that
are often used together to improve the developer experience for common
workflows.

## Connecting two nodes with an edge

Creating new nodes of a model is straightforward. To create a new post and
associate it with an author we can run the *createPost* mutation:

```graphql
  mutation {
    createPost(
      imageUrl: "https://unsplash.it/200/300?image=211"
      description: "#boat #beautiful"
      authorId: "author-id"
    ) {
      id
    }
  }
```

But what if you want to create a new post and associate it with a non-existing
author? One way to do this is to create the author first and then run
*createPost* from above. Another way is to create the post first, then the
author and then use the *addToPostAuthor* mutation to create a new edge between
the two new nodes.

## Simpler workflows with nested mutations

However, this isn't really intuitive. To simplify the developing workflow we now
provide the option to call only *one* mutation that already takes care of
everything. As a bonus, front end applications benefit from the reduced amount
of network requests.

These new mutations are called **nested mutations** and are a shortcut for the
workarounds mentioned above. They look like this:

![](./nested-mutations-example.png)

By nesting the *author* argument inside the *createPost* mutation we can now
easily create an author and a post and connect them at the same time! We rolled
out this feature to both the [Simple API](!alias-heshoov3ai) and the [Relay API](!alias-aizoong9ah). 🎉

## Conclusion

Even though GraphQL is not bleeding edge technology anymore, best practices for
many common problems have yet to emerge. By providing simple solutions like
nested mutations we are proud to push things forward in that regard.

What are common problems you face when working with GraphQL? Join our [Slack channel](http://slack.graph.cool/) to start a discussion. If you haven't done so already, you can [request early access to Graphcool here](https://graph.cool/).
