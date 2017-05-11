---
alias: eicha8ooph
path: /docs/faq/graphcool-location-type
layout: FAQ
title: How to model Locations in GraphQL?
description: In many applications, working with locations is of particular interest. Learn about best practices for the location type in GraphQL.
tags:
  - platform
  - locations
  - data-schema
related:
  further:
    - ij2choozae
    - teizeit5se
    - goh5uthoc1
    - emaig4uiki
  more:
    - aroozee9zu
---

# How to model Locations in GraphQL?

In many applications, working with locations is of particular interest. Read on to learn about best practices for modelling locations.

## Create the Location Type

First, create a new `Location` type that you use to manage location types in your application.

![](./create-location-model.gif)

This type encapsulates the latitude and longitude information in a single entity and also enables further extensions such as additional fields or relations.

## Add Fields for Longitude and Latitude

Now we add the `lng` and `lat` float fields to store longitute and latitude.

![](./create-location-fields.gif)

## Add additional Fields

Now you can think of additional fields that you want to be associated with a location. For example a `name` field to store the name of the location.

## Add Relations with the Location Type

Let's add a one-to-one relation between the `User` and `Location` type.

![](./create-location-relation.gif)

## Using Locations for Algolia Geosearch

We can use the `Location` type to power Algolia Geosearch. To make that work, you need a special setup based on Algolia's API:

* the location values need to be stored in a location type with the fields `lng` and `lat` of type float
* when defining the search index, you need to use an alias `_geoloc` for nested location type

For example, if we wanted to do a location search for shops, we could define this Algolia index query on the `Shop` type:

```graphql
{
  node {
    name
    _geoloc: location {
      lat
      lng
    }
  }
}
```

See [here](https://www.algolia.com/doc/guides/geo-search/geo-search-overview/) for more information on Algolia Geosearch.
