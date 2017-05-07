---
alias: uhieg2shio
path: /docs/reference/schema/system-artifacts
layout: REFERENCE
description: In order to make the platform as seamless and integrated as possible, we introduced some predefined artifacts in each project.
tags:
  - platform
  - system
  - models
  - fields
related:
  further:
    - ahwoh2fohj
    - teizeit5se
    - ij2choozae
    - goh5uthoc1
  more:
    - eefoovo2ah
    - goij0cooqu
---

# System Artifacts

In order to make the platform as seamless and integrated as possible, we introduced some predefined artifacts in each project. These artifacts are designed to be as minimal as possible and cannot be deleted. At the moment there are two type of artifacts: *system models* and *system fields*.

## `User` Model

Every project has a system model called `User`. As the `User` model is the foundation for our [built-in authentication system](!alias-wejileech9) you cannot delete it. But of course you can still extend the `User` model to suit your needs and it behaves like every other model.

Apart from the predefined system fields, the `User` model can have additional system fields depending on the enabled [auth providers](!alias-wejileech9#auth-providers).

You can add additional [fields](!alias-teizeit5se) as with any other model.

## `File` Model

The `File` model is part of our [file management](!alias-eer4wiang0). Every time you upload a file, a new `File` node is created. Aside from the predefined system fields, the `File` model contains several other fields that contain meta information:
* `contentType: `: our best guess as to what file type the file has. For example `image/png`. Can be `null`
* `name: String`: the complete file name including the file type extension. For example `example.png`.
* `secret: String`: the file secret. Can be combined with your project id to get the file url. Everyone with the secret has access to the file!
* `size: Integer`: the file size in bytes.
* `url: String`: the file url. Looks something like `https://files.graph.cool/__PROJECT_ID__/__SECRET__`, that is the generic location for files combined with your project id endpoint and the file secret.

You can add additional [fields](!alias-teizeit5se) as with any other model.

## `id` Field

Every model has a [required](!alias-teizeit5se#required) system field with the name `id` of type [ID](!alias-teizeit5se#id). The `id` value of every node (regardless of the model) is globally unique and unambiguously identifies a node ([as required by Relay](https://facebook.github.io/relay/docs/graphql-object-identification.html)). You cannot change the value for this field.

## `createdAt` and `updatedAt` Fields

Every model has the [DateTime](!alias-teizeit5se#datetime) fields `createdAt` and `updatedAt` that will be set automatically when a node is created or updated. You cannot change the values for these fields.
