_ = require 'lodash'
moment = require 'moment'
AssocArray = require '../helpers/assoc_array'
camelizeKeys = require '../helpers/camelize_keys'

class Base
  @dateFields: (newValue...) ->
    return @dateFieldsValue if arguments.length == 0
    @dateFieldsValue = newValue

  @dateFields 'createdAt', 'updatedAt'

  @hasOne: (field, model) ->
    @assocs ||= []
    @assocs.push { field, model, type: 'hasOne' }

  @hasMany: (field, model) ->
    @assocs ||= []
    @assocs.push { field, model, type: 'hasMany' }

  constructor: (data = {}) ->
    @defineDateAccessors()
    @defineAssocAccessors()
    _.merge @, camelizeKeys(data)

  defineDateAccessors: ->
    @constructor.dateFields().each (field) =>
      value = null

      Object.defineProperty @, field,
        get: ->
          value

        set: (newValue) ->
          value = moment new Date newValue

  defineAssocAccessors: ->
    @constructor.assocs?.each (assoc) =>
      @["define#{_.str.classify assoc.type}Accessor"](assoc)

  defineHasOneAccessor: ({field, model}) ->
    value = null

    Object.defineProperty @, field,
      get: ->
        value

      set: (newValue) ->
        newValue = new model newValue if newValue and newValue.constructor != model
        value = newValue

  defineHasManyAccessor: ({field, model}) ->
    value = AssocArray.create [], model

    Object.defineProperty @, field,
      get: ->
        value

      set: (newValue) ->
        value = AssocArray.create newValue, model

module.exports = Base
