xml2js          = require 'xml2js'
{Google, Image} = require './query'

exports.Request = class Request
  @parse: (data) ->
    parser = new xml2js.Parser()
    parser.addListener 'end', (res) ->
      if res.body?
        match = res.body.match /(\w+)\s+(\w+)/
        if match?
          command = match[1]
          query   = match[2]
          if command == 'google'
            output = Google.execute query
          if command == 'image'
            output = Image.execute query
      output ?= Request.help()
      console.log output
      output
    parser.parseString data.toString()

  @help: ->
    """
    google <query>
    image <query>
    """
