_ = require 'lodash'
moment = require 'moment'
AssocArray = require '../helpers/assoc_array'
camelcaseKeys = require '../helpers/camelcase_keys'

class Base
  @dateFields: (newValue...) ->
    return @dateFieldsValue if arguments.length == 0
    @dateFieldsValue = newValue

  @imageFields: (newValue...) ->
    return @imageFieldsValue if arguments.length == 0
    @imageFieldsValue = newValue

  @dateFields 'createdAt', 'updatedAt'

  @hasOne: (field, model) ->
    @assocs ||= []
    @assocs.push { field, model, type: 'hasOne' }

  @hasMany: (field, model) ->
    @assocs ||= []
    @assocs.push { field, model, type: 'hasMany' }

  constructor: (data = {}) ->
    @defineDateAccessors()
    @defineImageAccessors()
    @defineAssocAccessors()
    @update data

  clone: ->
    new @constructor @

  update: (data) ->
    _.merge @, camelcaseKeys(data)

  isPersisted: ->
    @id?

  isNewRecord: ->
    not @isPersisted()

  defineDateAccessors: ->
    @constructor.dateFields().forEach (field) =>
      value = null

      Object.defineProperty @, field,
        enumerable: true

        get: ->
          value

        set: (newValue) ->
          value = moment new Date newValue

  defineImageAccessors: ->
    @constructor.imageFields()?.forEach (field) =>
      value = null

      urlFor = (size) =>
        return value unless value? or size?
        value.replace /\/([^\/]+)$/, (match, submatch) ->
          "/#{size}_#{submatch}"

      Object.defineProperty @, field,
        enumerable: true

        get: ->
          urlFor()

        set: (newValue) ->
          value = newValue

      @["#{field}Url"] = urlFor

  defineAssocAccessors: ->
    @constructor.assocs?.forEach (assoc) =>
      @["define#{_.capitalize _.camelCase assoc.type}Accessor"](assoc)

  defineHasOneAccessor: ({field, model}) ->
    value = null

    Object.defineProperty @, field,
      enumerable: true

      get: ->
        value

      set: (newValue) ->
        newValue = new model newValue if newValue and newValue.constructor != model
        @["#{field}Id"] = if newValue then newValue.id else null
        value = newValue

  defineHasManyAccessor: ({field, model}) ->
    value = AssocArray.create [], model

    Object.defineProperty @, field,
      enumerable: true

      get: ->
        value

      set: (newValue) ->
        value = AssocArray.create newValue, model

module.exports = Base
