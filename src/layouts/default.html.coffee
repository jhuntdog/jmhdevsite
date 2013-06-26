---
title: 'Benjamin Lupton'
---

# Prepare
documentTitle = @getPreparedTitle()

# HTML
doctype 5
html lang: 'en', ->
  head ->
    # Standard
    meta charset: 'utf-8'
    meta 'http-equiv': 'X-UA-Compatible', content: 'IE=edge,chrome=1'
    meta 'http-equiv': 'content-type', content: 'text/html; charset=utf-8'
    meta name: 'viewport', content: 'width=device-width, initial-scale=1'
    text  @getBlock('meta').toHTML()

    # SEO
    title documentTitle
    meta name: 'title', content: documentTitle
    meta name: 'author', content: @getPreparedAuthor()
    meta name: 'email', content: @getPreparedEmail()
    meta name: 'description', content: @getPreparedDescription()
    meta name: 'keywords', content: @getPreparedKeywords()

    # Styles
    text  @getBlock('styles').add(@site.styles).toHTML()
    link rel: 'stylesheet', href: "/styles/style.css?v=#{@site.version}", media: 'screen, projection'
    link rel: 'stylesheet', href: "/styles/print.css?v=#{@site.version}", media: 'print'

  body ->
    # Modals
    aside '.modal.contact', -> @partial('content/contact')
    aside '.modal.backdrop', ->

    # Heading
    header '.heading', ->
      a href:'/', title:'Return home', ->
        h1 -> @site.text.heading
        span '.heading-avatar', ->
      h2 -> @site.text.subheading

    # navigation
    nav '.pages', ->
      ul ->
        for page in @getCollection('pages').toJSON()
          pageMatch = page.match or page.url
          documentMatch = @document.match or @document.url
          cssname = if documentMatch.indexOf(pageMatch) is 0 then 'active' else 'inactive'
          li 'class':cssname, ->
            a href:page.url, title:page.menuTitle, ->
              page.menuText or page.name





    # Footing
    footer '.footing', ->
      div '.about', -> @site.text.about
      div '.copyright', -> @site.text.copyright


    # Scripts
    text @getBlock('scripts').add(@site.scripts).toHTML()
