# content


master | dev
--- | ---
[![CircleCI](https://circleci.com/gh/graphcool/content/tree/master.svg?style=svg)](https://circleci.com/gh/graphcool/content/tree/master) | [![CircleCI](https://circleci.com/gh/graphcool/content/tree/dev.svg?style=svg)](https://circleci.com/gh/graphcool/content/tree/dev)


:notebook: [Documentation](https://graph.cool/docs) for Graphcool.

* [Read the reference docs](https://graph.cool/docs/reference)
* [Browse the FAQ](https://graph.cool/docs/faq)
* [Find tutorials](https://graph.cool/docs/tutorials)
* [Read the blog](https://graph.cool/blog)

## Add a new article

There are different types of articles:

* `BLOG` - a blog article located in `content/blog`
* `FAQ` - an faq article located in `content/faq`
* `REFERENCE` - a reference article located in `content/reference`
* `TUTORIAL` - a tutorial located in `content/tutorial`

Different article types need different properties in their frontmatter. For a valid frontmatter, have a look at one of the existing articles.

### Gotchas

* Use the alias of the article to be linked to for internal links:

```
Look in the [Simple API](!alias-heshoov3ai)
```

* Don't start links with `www` but with `https://` or `http://`:

```
Learn more at [the official GraphQL documentation](https://www.graphql.org)
```

* Aliases are a unique alphanumeric string of length 10, that may contain either lower case letters or digits. **Aliases have to start with a letter**. You can create a new alias with

```sh
pwgen -A 10 1
```
