_ = require 'lodash'

classify = (str = '') ->
  _.camelCase _.capitalize str

module.exports = ->
  _.mixin { classify }
