_ = require 'lodash'

idFields = ['id', 'cid', 'slug']

defaultOpts =
  all: false
  fields: idFields

extractIds = (obj, fields) ->
  _(fields).map(_.propertyOf(obj)).compact().value()

findIndexInStore = (store, data, opts = {}) ->
  return unless data?

  {all, fields} = _.defaults opts, defaultOpts
  ids = _ if _.isObject(data) then extractIds(data, fields) else [data]
  state = store.getState()
  filter = (record) ->
    not ids.intersection(extractIds(record, fields)).isEmpty()

  return _.findIndex state, filter unless all

  _ state
    .map (record, index) -> if filter(record) then index else null
    .filter (index) -> index?
    .value()

module.exports = findIndexInStore
