React = require 'react/addons'
Marty = require 'marty'
Nothing = require '../shared/nothing'

{PropTypes} = React

Loader = React.createClass
  displayName: 'Loader'

  propTypes:
    visible: PropTypes.bool.isRequired

  render: ->
    {visible} = @props

    return <Nothing/> unless visible

    <div className="layout_loader"></div>

module.exports = Marty.createContainer Loader,
  listenTo: 'loaderVisibilityStore'

  fetch: ->
    visible: @app.loaderVisibilityStore.get().visible
