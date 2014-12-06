_ = require 'lodash'
moment = require 'moment'
camelizeKeys = require '../helpers/camelize_keys'

class Base
  @dateFields: (newValue...) ->
    return @dateFieldsValue if _.isEmpty newValue
    @dateFieldsValue = newValue

  @dateFields 'createdAt', 'updatedAt'

  constructor: (data = {}) ->
    @defineDateAccessors()
    _.merge @, camelizeKeys(data)

  defineDateAccessors: ->
    @constructor.dateFields().each (field) =>
      value = null

      Object.defineProperty @, field,
        get: ->
          value

        set: (newValue) ->
          value = moment newValue

module.exports = Base
