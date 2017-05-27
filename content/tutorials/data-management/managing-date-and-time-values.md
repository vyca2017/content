---
alias: ier7sa3eep
path: /docs/tutorials/managing-date-and-time
layout: TUTORIAL
preview: time-icon.png
description: Manage date and time values with the ISO 8601 format when working with your GraphQL server.
tags:
  - functions
  - mutation-callbacks
  - webtask
  - plain-http
related:
  further:
    - ahwoh2fohj
    - ij2choozae
    - goh5uthoc1
    - uhieg2shio
  more:
    - ga2ahnee2a
    - uu2xighaef
---

# Managing date and time values

Working with date and time values in your application can be quite tricky. Learn how to efficiently work with them using [DateTime](!alias-teizeit5se#DateTime) fields in your Graphcool project.

## The ISO 8601 format

Using the standardized [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601) when using dates and times has evolved to a best practice.
A few example values in this format are `2015-11-22`, `2015-11-22T12:43Z`, `2015-11-22T12:43:30.123Z`. What is special about this format is that date and time values are ordered from the largest to smallest unit: Year, month, day, hour, minute, second, milliseconds.

While it is not a mandatory part of the standard, times expressed in ISO 8601 format are highly recommended to include information on the time zone at the end, expressed in the time offset from UTC (for example +01:00) or a `Z` specifying UTC.

## Querying DateTime fields with the APIs

The [DateTime](!alias-teizeit5se#DateTime) values returned from the [Simple API](!alias-heshoov3ai) and [Relay API](!alias-aizoong9ah) are specified using the UTC time zone. An example would be `2015-11-22T13:07:22.000Z`. Depending on your application need, you may either want to display that time value in UTC or the local time zone of the user.

An example where you would want to display the same value independently of the local time zone of your users are birthdays. The time a comment was posted would be a good use case for displaying the time in the local time zone.

> Depending on your use case and application, you have to decide whether you want to display the date and time values in UTC or the local time zone.

## Storing date and time values in your Graphcool project

If you want to store date and time values in your Graphcool project you should convert them to the ISO 8601 format first and use the UTC time zone. If you don't express the value in UTC, your data might be wrongfully altered, as the APIs assume a UTC timezone if not otherwise specified.
In JavaScript, you can use the `toISOString` method on `Date` objects. First, make sure to set the time zone of the environment to UTC:

```js
// set timezone to UTC
process.env.TZ = 'UTC'
```

Setting the time zone like that can only occur once per execution and cannot be changed later. If you need more flexible behaviour with time zones, you can use libraries like [Moment.js](http://momentjs.com/).

To then format a date time string as a ISO 8601 string, you can use `Date.parse` and `toISOString`:

```js
new Date(Date.parse('4 Jul 2012')).toISOString() // '2012-07-04T00:00:00.000Z'
```

You can now use this value in a query or mutation by enclosing it in double quotes.

In other languages, there exist different best practices surrounding the management of date and time. In Java and Android for example, you might use a library like [Joda Time](http://www.joda.org/joda-time/) to convert your values to ISO 8601.

## DateTime fields in the Console

Even though [DateTime](!alias-teizeit5se#DateTime) values are stored in UTC, they are displayed in your local time zone when using the [console](http://console.graph.cool).
