_ = require 'lodash'
Marty = require 'marty'
deepCamelcaseKeys = require '../helpers/deep_camelcase_keys'

responseKeys = ['type', 'url', 'ok', 'status', 'statusText']

module.exports = ->
  Marty.HttpStateSource.addHook
    id: 'CamelcaseResponseBody'

    after: (response) ->
      _.merge body: deepCamelcaseKeys(response.body), _.pick(response, responseKeys)
