axios = require 'axios'

module.exports = ->
  axios.interceptors.request.use (config) ->
    return if /^(http|\/)/.test config.url
    config.url = "/api/private/#{config.url}"
    config
