_ = require 'lodash'
createFragment = require 'react-addons-create-fragment'

withIndexKeys = (components) ->
  return unless components?
  createFragment _.mapKeys components, (__, index) -> '$' + index

module.exports = withIndexKeys
