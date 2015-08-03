React = require 'react/addons'

{PropTypes} = React

AppToContext =
  childContextTypes:
    app: PropTypes.object.isRequired

  getChildContext: ->
    { @app }

module.exports = AppToContext
