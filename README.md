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

### Frontmatter

There are different types of articles:

* `BLOG` - a blog article located in `content/blog`
* `FAQ` - an faq article located in `content/faq`
* `REFERENCE` - a reference article located in `content/reference`
* `TUTORIAL` - a tutorial located in `content/tutorial`

Different article types need different properties in their frontmatter. For a valid frontmatter, have a look at one of the existing articles.

### Gotchas

* The description of an article must not be longer than 160 characters.

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

## Contributors

A big thank you to all contributors and supporters of this repository 💚 

<a href="https://github.com/marktani/" target="_blank">
  <img src="https://github.com/marktani.png?size=64" width="64" height="64" alt="marktani">
</a>
<a href="https://github.com/nikolasburk/" target="_blank">
  <img src="https://github.com/nikolasburk.png?size=64" width="64" height="64" alt="nikolasburk">
</a>
<a href="https://github.com/schickling/" target="_blank">
  <img src="https://github.com/schickling.png?size=64" width="64" height="64" alt="schickling">
</a>
<a href="https://github.com/sorenbs/" target="_blank">
  <img src="https://github.com/sorenbs.png?size=64" width="64" height="64" alt="sorenbs">
</a>
<a href="https://github.com/timsuchanek/" target="_blank">
  <img src="https://github.com/timsuchanek.png?size=64" width="64" height="64" alt="timsuchanek">
</a>
<a href="https://github.com/lastmjs/" target="_blank">
  <img src="https://github.com/lastmjs.png?size=64" width="64" height="64" alt="lastmjs">
</a>
<a href="https://github.com/artyomchel/" target="_blank">
  <img src="https://github.com/artyomchel.png?size=64" width="64" height="64" alt="artyomchel">
</a>
<a href="https://github.com/notrab/" target="_blank">
  <img src="https://github.com/notrab.png?size=64" width="64" height="64" alt="notrab">
</a>
<a href="https://github.com/khankuan/" target="_blank">
  <img src="https://github.com/khankuan.png?size=64" width="64" height="64" alt="khankuan">
</a>
<a href="https://github.com/danieljvdm/" target="_blank">
  <img src="https://github.com/danieljvdm.png?size=64" width="64" height="64" alt="danieljvdm">
</a>
<a href="https://github.com/sedubois/" target="_blank">
  <img src="https://github.com/sedubois.png?size=64" width="64" height="64" alt="sedubois">
</a>
<a href="https://github.com/philippbosch/" target="_blank">
  <img src="https://github.com/philippbosch.png?size=64" width="64" height="64" alt="philippbosch">
</a>
<a href="https://github.com/helfer/" target="_blank">
  <img src="https://github.com/helfer.png?size=64" width="64" height="64" alt="helfer">
</a>
<a href="https://github.com/thangngoc89/" target="_blank">
  <img src="https://github.com/thangngoc89.png?size=64" width="64" height="64" alt="thangngoc89">
</a>
<a href="https://github.com/c316/" target="_blank">
  <img src="https://github.com/c316.png?size=64" width="64" height="64" alt="c316">
</a>
<a href="https://github.com/richardkall/" target="_blank">
  <img src="https://github.com/richardkall.png?size=64" width="64" height="64" alt="richardkall">
</a>
<a href="https://github.com/timneutkens/" target="_blank">
  <img src="https://github.com/timneutkens.png?size=64" width="64" height="64" alt="timneutkens">
</a>
<a href="https://github.com/jkeat/" target="_blank">
  <img src="https://github.com/jkeat.png?size=64" width="64" height="64" alt="jkeat">
</a>
<a href="https://github.com/yergi/" target="_blank">
  <img src="https://github.com/yergi.png?size=64" width="64" height="64" alt="yergi">
</a>
<a href="https://github.com/gabric098/" target="_blank">
  <img src="https://github.com/gabric098.png?size=64" width="64" height="64" alt="gabric098">
</a>
<a href="https://github.com/mikexstudios/" target="_blank">
  <img src="https://github.com/mikexstudios.png?size=64" width="64" height="64" alt="mikexstudios">
</a>
<a href="https://github.com/rafklu/" target="_blank">
  <img src="https://github.com/rafklu.png?size=64" width="64" height="64" alt="rafklu">
</a>
<a href="https://github.com/artyomc/" target="_blank">
  <img src="https://github.com/artyomc.png?size=64" width="64" height="64" alt="artyomc">
</a>
<a href="https://github.com/dpetrick/" target="_blank">
  <img src="https://github.com/dpetrick.png?size=64" width="64" height="64" alt="dpetrick">
</a>
<a href="https://github.com/kandros/" target="_blank">
  <img src="https://github.com/kandros.png?size=64" width="64" height="64" alt="kandros">
</a>
<a href="https://github.com/MacsDickinson/" target="_blank">
  <img src="https://github.com/MacsDickinson.png?size=64" width="64" height="64" alt="MacsDickinson">
</a>
<a href="https://github.com/dervos/" target="_blank">
  <img src="https://github.com/dervos.png?size=64" width="64" height="64" alt="dervos">
</a>
<a href="https://github.com/Igor-Senshov/" target="_blank">
  <img src="https://github.com/Igor-Senshov.png?size=64" width="64" height="64" alt="Igor-Senshov">
</a>
<a href="https://github.com/brenmcnamara/" target="_blank">
  <img src="https://github.com/brenmcnamara.png?size=64" width="64" height="64" alt="brenmcnamara">
</a>

## Help & Community [![Slack Status](https://slack.graph.cool/badge.svg)](https://slack.graph.cool)

Join our [Slack community](http://slack.graph.cool/) if you run into issues or have questions. We love talking to you!

![](http://i.imgur.com/5RHR6Ku.png)
