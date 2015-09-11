axios = require 'axios'
deepCamelcaseKeys = require '../helpers/deep_camelcase_keys'

module.exports = ->
  axios.interceptors.response.use (response) ->
    response.data = deepCamelcaseKeys response.data
    response
