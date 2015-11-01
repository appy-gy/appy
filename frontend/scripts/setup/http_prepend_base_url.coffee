http = require '../helpers/http'
isClient = require '../helpers/is_client'

module.exports = ->
  prefix = '/api/private'
  prefix = "#{process.env.TOP_API_HOST}#{prefix}" unless isClient()

  http.interceptRequest (config) ->
    config.url = "#{prefix}/#{config.url}" unless /^(http|\/)/.test config.url
    config
