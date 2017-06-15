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

## Week 24 (June 12 - June 18)

* The [Image API](!alias-atiede8ata) is now production ready.
* The [Graphcool CLI](https://github.com/graphcool/graphcool-cli/) shows more information for invalid commands and received multiple bug fixes. [Full Release Notes](https://github.com/graphcool/graphcool-cli/releases/tag/v1.1.0).

## Week 23 (June 5 - June 11)

- The [data export](!alias-aechi6iequ) feature now supports UTF8 encoding
- Fixed a problem with Algolia Index queries that were not containing the node `id`
- Based on the community feedback [Graphcool Functions](!alias-boo6uteemo) could be improved in many aspects:
  - Functions now support scalar lists, DateTime and Json fields
  - Functions now work correctly when triggered by a nested mutation
  - `PRE_WRITE` functions in the [request pipeline](!alias-pa6guruhaf) now receive the transformed output if a `TRANSFORM_ARGUMENT` function exists
- The `Select User` feature in the [Graphcool Playground](!alias-oe1ier4iej) now works with [GraphQL Subscriptions](!alias-aip7oojeiv) as expected.
- The [Getting Started with Relay](!alias-woodito7ug) tutorial and video guide have been released!
- The project settings, Algolia integration, different popups and more in the [Graphcool Console](https://console.graph.cool) received a lot of UI and UX improvements for Chrome, Safari and Firefox.

## Week 22 (May 29 - June 4)

- We released new guides for [functions along the request pipeline](!alias-zeez7aiph3) and [server-side subscriptions](!alias-dee0aethoo).
- With [graphql-request](https://github.com/graphcool/graphql-request) we published a minimal GraphQL client supporting Node and browsers for scripts or simple apps.
- We restructured our [examples repository](https://github.com/graphcool-examples) to help you find exactly the example that you need and also updated the onboarding accordingly.
- For better support of Relay Modern, we added more choices to the schema export feature. You can now export the full schema needed for Relay Modern and other tools right in your Console!

## Week 21 (May 22 - May 28)

- Our homepage received layout fixes, a new [community section in the docs](https://graph.cool/docs) and a faster signup flow
- In the Console, we released a brandnew onboarding that is even more interactive than before, introduced a mobile landing page, improved the UI for entering values in the field popup and introduced a new fullscreen mode for testing functions
- Queries that involve Permission queries now have up to 10x better performance
- The [fifth chapter of the Freecom tutorial series](!alias-wohfoa8ahz) is finally here and showcases how you can employ business logic with serverless functions.

## Week 20 (May 15 - May 21)

- We **launched officially** and were featured on [Product Hunt](https://www.producthunt.com/posts/graphcool-2) and reached first spot on the [Hacker News](https://news.ycombinator.com/item?id=14350129) frontpage 🎉 We published an article [about the Serverless GraphQL Backend Architecture](!alias-ahde7paig2/) and rolled out the [CLI and Functions](!alias-teko4ab8za).
- As part of the launch, the homepage and documentation received a lot of love and should feel way smoother now.
- We fixed issues with the [Algolia Integration](!alias-emaig4uiki) regarding nested nodes, made a lot of smaller improvements to the UX of the Console and fixed a bug that would apply too restrictive permissions for some mutations.
- On May 21th, we're hosting [GraphQL Europe](https://graphql-europe.org), the first GraphQL conference in Europe.

## Week 19 (May 8 - May 14)

- We incorporated the feedback we received regarding the UX of the Anonymous Authentication in the Console.
- The new [CLI](!alias-kie1quohli) and the [Functions](!alias-boo6uteemo) feature are being tested in a closed beta program.

## Week 18 (May 1 - May 7)

- Enums are now managed on a project-level instead a type-level. This means you can define the possible values for one enum and create fields that use this enum in different types now.
- We added a new authentication provider that allows authentication based on a unique secret: **Anonymous Authentication**. Check [the latest Freecom chapter](!alias-pei9aid6ei) to learn how to use it!

## Week 17 (April 24 - April 30)

- We [released permission queries](![alias](https://www.graph.cool/blog/2017-04-25-graphql-permission-queries)-oolooch8oh/)! This is a novel approach for customizable authorization rules and we're very excited about the launch. Thanks to the **over 100 developers** in our beta program for throroughly testing this feature!
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
- Performance and usability for the [Subscriptions API](!alias-aip7oojeiv) has been dramatically increased based on the feedback we received from the community.
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
