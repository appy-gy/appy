_ = require 'lodash'

idFields = ['id', 'cid', 'slug']

defaultOpts =
  all: false
  fields: idFields

extractIds = (obj, fields) ->
  _(fields).map(_.propertyOf(obj)).compact().value()

findIndexInArray = (array, data, opts = {}) ->
  return unless data?

  {all, fields} = _.defaults opts, defaultOpts
  ids = _ if _.isObject(data) then extractIds(data, fields) else [data]
  filter = (record) ->
    not ids.intersection(extractIds(record, fields)).isEmpty()

  return _.findIndex array, filter unless all

  _ array
    .map (record, index) -> if filter(record) then index else null
    .filter (index) -> index?
    .value()

module.exports = findIndexInArray
