{EventEmitter} = require "events"
{jsdom}        = require 'jsdom'

class Query extends EventEmitter

  constructor: ->
    console.log "Query says hey"

  jQueryURI = 'https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js'

  formatLink: (link) ->
    link.attr('href') + " - " + link.text()

  results: []

  @execute: (data) ->
    query = new @(data)
    jsdom.env query.uri, [jQueryURI], (errors, window) ->
      $ = window.$
      $(query.selector).map ->
        link = $(this)
        query.results.push query.formatLink(link)
      console.log query.results

exports.Google = class Google extends Query
  constructor: (@query) ->
    @uri      = "http://www.google.com/search?q=#{query}"
    @selector = '#ires ol li .r a'

exports.Image = class Image extends Query
  constructor: (@query) ->
    @uri     = "http://images.google.com/search?tbm=isch&biw=1140&bih=983&q=#{query}"
    @pattern = '#ires ol li .rg .rg_ctlv'
