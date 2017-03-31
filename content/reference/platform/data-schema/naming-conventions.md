---
alias: oe3raifamo
path: /docs/reference/platform/naming-conventions
layout: REFERENCE
description: The different objects you encounter in a Graphcool project like models or relations follow separate naming conventions to help you distinguish them.
tags:
  - platform
  - queries
  - mutations
  - relations
  - fields
  - data-schema
related:
  further:
    - teizeit5se
    - ij2choozae
    - goh5uthoc1
  more:
    - eicha8ooph
---

# Naming Conventions

Different objects you encounter in a Graphcool project like models or relations follow separate naming conventions to help you distinguish them.

## Projects

Project names can contain **alphanumeric characters and spaces** and need to start with an uppercase letter. They can contain **maximally 64 characters**.

*Project names are unique on an account level.*

#### Examples

* `My Project`
* `MyProject2`
* `MY PROJECT`

## Models

The model name determines the name of derived queries and mutations as well as the argument names for nested mutations. Model names can only contain **alphanumeric characters** and need to start with an uppercase letter. They can contain **maximally 64 characters**.

*It's recommended to choose model names in the singular form.*  
*Model names are unique on a project level.*

#### Examples

* `Post`
* `PostCategory`

## Scalar and Relation Fields

The name of a scalar field is used in queries and in query arguments of mutations. Field names can only contain **alphanumeric characters** and need to start with a lowercase letter. They can contain **maximally 64 characters**.

The name of relation fields follows the same conventions and determines the argument names for relation mutations.

*It's recommended to only choose plural names for list fields*.  
*Field names are unique on a model level.*

#### Examples

* `name`
* `email`
* `categoryTag`

## Relations

The relation name determines the name of mutations to connect or disconnect nodes in the relation. Relation names can only contain **alphanumeric characters** and need to start with an uppercase letter. They can contain **maximally 64 characters**.

*Relation names are unique on a project level.*

#### Examples

* `UserOnPost`, `UserPosts` or `PostAuthor`, with field names `user` and `posts`
* `EmployeeAppointments`, `EmployeeOnAppointment` or `AppointmentEmployee`, with field names `employee` and `appointments`

## Enum Values

Enum values can only contain **alphanumeric characters and underscores** and need to start with an uppercase letter.
The name of an enum value can be used in query filters and mutations. They can contain **maximally 191 characters**.

*Enum names are unique on a field level.*

#### Examples

* `A`
* `ROLE_TAG`
* `ROLE_TAG2`
