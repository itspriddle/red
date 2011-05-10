sys       = require 'sys'
xmpp      = require 'node-xmpp'
{Request} = require './request'

presencePacket =
  new xmpp.Element('presence', {}).
  c('show').t('chat').up().c('status').
  t('Happily echoing your <message/> stanzas')

exports.Client = class Client
  @connect: (config) ->
    new @(config)

  constructor: (config) ->
    @client = new xmpp.Client config

    # Set presence
    @client.on 'online', ->
      @send presencePacket

    # Echo back errors
    @client.on 'error', (e) ->
      console.log e

    @client.on 'stanza', (stanza) ->
      console.log stanza
      if stanza.is('message') && stanza.attrs.type != 'error'
        req = Request.parse stanza
        console.log req

#     @client.on
# client.on 'foo'
#   message = new xmpp.Element('message', to: from, type: chat).c('body').t("Yes, boss?")
#   @send message
#
# client.on 'stanza', (stanza) ->
#
#
#
#
# res.on 'end', (reply) =>
#   stanza = reply.stanza
#   res = reply.response
#   if stanza? and res?
#     cl.send new xmpp.Element('message', {to: stanza.attrs.from, type: 'chat'}).c('body').t(res)
#
# cl.on 'online', ->
#   cl.send(new xmpp.Element 'presence', {}).
#   c('show').t('chat').up().c('status').t('Happily echoing your <message/> stanzas')
#
#
#
#
#   res.on 'end', (reply) =>
#     stanza = reply.stanza
#     res = reply.response
#     if stanza? and res?
#       cl.send new xmpp.Element('message', {to: stanza.attrs.from, type: 'chat'}).c('body').t(res)
#
#   cl.on 'online', ->
#     cl.send(new xmpp.Element 'presence', {}).
#     c('show').t('chat').up().c('status').t('Happily echoing your <message/> stanzas')