_ = require 'lodash'

Snapshot =
  create: (record) ->
    _.omit record, _.isFunction

  restore: (record, snapshot) ->
    _.merge record, snapshot

  diff: (record, snapshot) ->
    _.pick record, (value, key) ->
      _.has(snapshot, key) and snapshot[key] != value

module.exports = Snapshot
