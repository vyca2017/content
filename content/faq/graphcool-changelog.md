---
alias: chiooo0ahn
path: /docs/faq/graphcool-changelog
layout: FAQ
title: Changelog
description: Keep track of the latest features and improvements to the Graphcool platform.
tags:
  - platform
related:
  further:
  more:
    - ul6ue9gait
    - oobai3shoh
---

# Changelog

## Week 18 (May 1 - May 7)

- Enums are now managed on a project-level instead a type-level. This means you can define the possible values for one enum and create fields that use this enum in different types now.
- We added a new authentication provider that allows authentication based on a unique secret: **Anonymous Authentication**. Check [the latest Freecom chapter](!alias-pei9aid6ei) to learn how to use it!

## Week 17 (April 24 - April 30)

- We [released permission queries](https://www.graph.cool/blog/2017-04-25-graphql-permission-queries-oolooch8oh/)! This is a novel approach for customizable authorization rules and we're very excited about the launch. Thanks to the **over 100 developers** in our beta program for throroughly testing this feature!
- We improved working with scalar lists in the databrowser.
- To make debugging subscriptions in the Playground easier, API errors are now directly printed.

## Week 16 (April 17 - April 23)

- [GraphQL Radio](https://graphqlradio.com) has been launched in cooperation with [Abhi Aiyer](https://twitter.com/AbhiAiyer).
- Many bugs have been fixed:
  - A subtle bug that prevented the deletion of nodes in self-relations with only a single field
  - Input data when creating or updating JSON fields is now properly validated and a GraphQL error is returned for invalid JSON.
  - The initial synchronization for the Algolia integration could be improved when using `DateTime` or `Json` fields.
- Improvements to relation filters, the File API and String fields:
  - It's now possible to filter nodes that are related to `null` in a to-one relation.
  - The size limit of uploading files to the [File API](!alias-eer4wiang0) has been increased to 200MB to support even big video files. File names now also support UTF-8 encoded characters.
  - [String fields](!alias-teizeit5se) can now hold up to 256 KB data, compared to 64KB before.

## Week 15 (April 10 - April 16)

- [Part 2 of the Freecom tutorial](!alias-oe8ahyo2ei) takes a deep dive into running GraphQL mutations and queries with Apollo Client.
- We improved the UI and workflow of connecting nodes in a relation using the Data Browser. This should feel much smoother now.

## Week 14 (April 3 - April 9)

- With the release of [Freecom](https://www.graph.cool/freecom/), we are kicking off a big full-stack tutorial series to build your own customer chat.
- Performance and usability for the [Subscriptions API](aip7oojeiv) has been dramatically increased based on the feedback we received from the community.
- Using default values and migrations for Enum and JSON fields have been improved.
- General improvements to migrations when changing a field in the Console.

## Week 13 (March 27 - April 2)

- You can now upload files using the Data Browser as per feature request [#66](https://github.com/graphcool/feature-requests/issues/66). Simply drag and drop a file into your console to upload it and create the corresponding file node.
- The [Homepage](https://graph.cool) including the [Documentation](https://graph.cool/docs) is now way more performant because we added code splitting and improved the Webpack configuration in general.
- The video about [building a booking system with GraphQl](https://www.youtube.com/watch?v=O8vwXEbnbFk) is the first episode of the Graphcool Webinar series.

## Week 12 (March 20 - March 26)

- For some people in the *Permissions Popup* it was not clear what we mean by "Apply to whole Model". A tooltip now explains what it's about. (closes [#536](https://github.com/graphcool/console/issues/536))
- Even when you didn't have changes, the databrowser asked if you really want to leave. This is fixed and now only real changes trigger this popup. (closes [#509](https://github.com/graphcool/console/issues/509))
- Fixed the links in the Onboarding for Learn Apollo & Learn Relay (closes [#756](https://github.com/graphcool/console/issues/756))
- The playground had the problem, that the docs didn't fully expand. Many of you have reported this, which we're really thankful for. It's now fixed and even on a small screen you can expand the docs much wider. (closes [#758](https://github.com/graphcool/console/issues/758), [#695](https://github.com/graphcool/console/issues/695))

## Week 11 (March 13 - March 19)

- We introduce [graphql-up](https://www.graph.cool/graphql-up/) that generates a ready-to-use GraphQL API based on a schema file in [IDL schema definition syntax](!alias-kr84dktnp0).
- Launch of the new Schema View. You now have a better overview over your schema through the GraphQL IDL view and an awesome tool called [GraphQL Voyager](https://github.com/APIs-guru/graphql-voyager/), which we've now included in the Graphcool Console for you.

## Week 10 (March 6 - March 12)

- In this week there was a lot of progress regarding the Schema View, which will be released next week.
- The Console now uses [Service Workers](https://developers.google.com/web/fundamentals/getting-started/primers/service-workers) which cache all assets so the whole Console loads faster.
- Minor Bugs like the behavior of the String Cell in the Databrowser have been fixed. (closes
[#703](https://github.com/graphcool/console/issues/703),
[#715](https://github.com/graphcool/console/issues/715),
[#734](https://github.com/graphcool/console/issues/734),
[#741](https://github.com/graphcool/console/issues/741),
[#744](https://github.com/graphcool/console/issues/744))

## Week 9 (February 27 - March 5)

- Launch of our new subscriptions. Not only have we iterated over the subscription API to make it as powerful and easy to use as possible, but also created a unique debugging experience for your GraphQL Subscriptions in the new playground. Give it a try!
