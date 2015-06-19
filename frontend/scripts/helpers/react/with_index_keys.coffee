_ = require 'lodash'
React = require 'react/addons'

{createFragment} = React.addons

withIndexKeys = (components) ->
  return unless components?
  createFragment _.mapKeys components, (__, index) -> '$' + index

module.exports = withIndexKeys
