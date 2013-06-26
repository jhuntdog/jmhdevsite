# =================================
# Misc Configuration

envConfig = process.env


# =================================
# DocPad Configuration

module.exports =
  #regenerateEvery: 1000*60*60  # hour

  # =================================
  # Template Data

  templateData:
    # Site Data
    site:
      version: require('./package.json').version
      url: "http://jasonhuntington.com"
      oldUrls: [
        'www.jmhuntington.com',
        'jmhuntington.azurewebsites.net/',
        'jmhuntington.herokuapp.com'
      ],
      title: "JasonHuntington"
      subtitle: "Jason Huntington Website"
      author: "Jason Huntington"
      email: "jason@jmhuntington.com"
      description: """
        Website of Jason Huntington. Just an average guy building a website.
        """
      keywords: """
        jasonhuntington, Jason Huntington, jhuntdog, jhunt, jasonmhuntington
        """

      text:
        heading: "Jason Huntington"
        subheading: '''
          <t render="html.coffee">
            link = @getPreparedLink.bind(@)
            text """
               Hunting for direction and experimenting with web applications.<br/>
               Available for consulting. #{link 'contact'}.
              """
          </t>
          '''
        about: '''
          <t render="html.coffee">
            link = @getPreparedLink.bind(@)
            text """
              This website was built with #{link 'bevry'}’s #{link 'docpad'}, powered by #{link 'nodejs'}, and is #{link 'source'}.
              """
          </t>
          '''
        copyright: '''
          <t render="html.md">
            Copyright © 2013 Jason Huntington<br/>
            Licensed [permissively](http://en.wikipedia.org/wiki/Permissive_free_software_licence) under the [MIT License](http://creativecommons.org/licenses/MIT/) for code and the [Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/) for everything else.
          </t>
          '''

      services:
        facebookFollowButton:
          applicationId: ''
          username: 'jasonmhuntington'
        twitterTweetButton: "jasonhuntington"
        twitterFollowButton: "jasonhuntington"
        githubFollowButton: "jhuntdog"
        linkedinButton: "jasonhuntington"
        googleAnalytics: 'UA-40082218-1'

      social:
        """
        googleplus
        linkedin
        twitter
        facebook
        github
        """.trim().split('\n')

      styles: []  # embedded in layout

      scripts: """
        /components/jquery/jquery.js
        /scripts/script.js
        """.trim().split('\n')

      feeds: [
          href: 'http://feeds.feedburner.com/jasonhuntington.atom'
          title: 'Blog Posts'
        ,
          href: 'https://github.com/jhuntdog.atom'
          title: 'GitHub Activity'
        ,
          href: 'https://api.twitter.com/1/statuses/user_timeline.atom?screen_name=jasonhuntington&count=20&include_entities=true&include_rts=true'
          title: 'Tweets'
      ]

      links:
        docpad:
          text: 'DocPad'
          url: 'http://docpad.org'
          title: 'Visit Website'
        hostel:
          text: 'Startup Hostel'
          url: 'http://startuphostel.org'
          title: 'Visit Website'
        backbonejs:
          text: 'Backbone.js'
          url: 'http://backbonejs.org'
          title: 'Visit Website'
        historyjs:
          text: 'History.js'
          url: 'http://historyjs.net'
          title: 'Visit Website'
        bevry:
          text: 'Bevry'
          url: 'http://bevry.me'
          title: 'Visit Website'
        services:
          text: 'Services'
          url: 'http://bevry.me/services'
          title: "View my company's services"
        opensource:
          text: 'Open-Source'
          url: 'http://en.wikipedia.org/wiki/Open-source_software'
          title: 'Visit on Wikipedia'
        html5:
          text: 'HTML5'
          url: 'http://en.wikipedia.org/wiki/HTML5'
          title: 'Visit on Wikipedia'
        javascript:
          text: 'JavaScript'
          url: 'https://developer.mozilla.org/en-US/docs/JavaScript'
          title: 'Visit on MDN'
        nodejs:
          text: 'Node.js'
          url: 'http://nodejs.org/'
          title: 'Visit Website'
        balupton:
          text: 'Benjamin Lupton'
          url: 'http://balupton.com'
          title: 'Visit Website'
        author:
          text: 'Jason Huntington'
          url: 'http://jasonhuntington.com'
          title: 'Visit Website'
        source:
          text: 'open-source'
          url: 'https://github.com/jhuntdog/jmhdev.website'
          title: 'View Website Source'
        contact:
          text: 'Contact'
          url: 'mailto:jason@jasonhuntington.com'
          title: 'Contact me'
          cssClass: 'contact-button'

    # Link Helper
    getPreparedLink: (name) ->
      link = @site.links[name]
      renderedLink = """
        <a href="#{link.url}" title="#{link.title}" class="#{link.cssClass or ''}">#{link.text}</a>
        """
      return renderedLink

    # Meta Helpers
    getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title
    getPreparedAuthor: -> @document.author or @site.author
    getPreparedEmail: -> @document.email or @site.email
    getPreparedDescription: -> @document.description or @site.description
    getPreparedKeywords: -> @site.keywords.concat(@document.keywords or []).join(', ')



  # =================================
  # Collections

  collections:
    pages: ->
      @getCollection('documents').findAllLive({menuOrder:$exists:true},[menuOrder:1])

    posts: ->
      @getCollection('documents').findAllLive({relativeOutDirPath:'blog'},[date:-1])


  # =================================
  # Events

  events:

    serverExtend: (opts) ->
      # Prepare
      docpadServer = opts.server

      latestConfig = docpad.getConfig()
      oldUrls = latestConfig.templateData.site.oldUrls or []
      newUrl = latestConfig.templateData.site.url

      # ---------------------------------
      # Server Configuration

      # Redirect Middleware
      docpadServer.use (req,res,next) ->
        if req.headers.host in oldUrls
          res.redirect(newUrl+req.url, 301)
        else
          next()



  # =================================
  # Plugin Configuration

  #plugins:


