axios = require 'axios'

module.exports = ->
  axios.interceptors.response.use (response) ->
    response.ok = 200 <= response.status < 300
    response
