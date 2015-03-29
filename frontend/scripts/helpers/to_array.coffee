_ = require 'lodash'

toArray = (item) ->
  if _.isArray item then item else [item]

module.exports = toArray
