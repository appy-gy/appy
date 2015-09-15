http = require '../helpers/http'
deepCamelcaseKeys = require '../helpers/deep_camelcase_keys'

module.exports = ->
  http.interceptResponse (response) ->
    response.data = deepCamelcaseKeys response.data
    response
