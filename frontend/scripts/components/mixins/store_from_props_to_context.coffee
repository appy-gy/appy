_ = require 'lodash'
React = require 'react/addons'

{PropTypes} = React

StoreFromPropsToContext =
  propTypes:
    store: PropTypes.object

  childContextTypes:
    store: PropTypes.object.isRequired

  getChildContext: ->
    _.pick @props, 'store'

module.exports = StoreFromPropsToContext
