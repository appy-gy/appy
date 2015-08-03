React = require 'react/addons'

{PropTypes} = React

AppFromProps =
  propTypes:
    app: PropTypes.object

  componentWillMount: ->
    {app} = @props

    @app ||= app

module.exports = AppFromProps
