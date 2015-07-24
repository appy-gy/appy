React = require 'react/addons'
Marty = require 'marty'
Nothing = require '../shared/nothing'

{PropTypes} = React

Loader = React.createClass
  displayName: 'Loader'

  propTypes:
    visibility: PropTypes.object.isRequired

  render: ->
    {visibility} = @props

    return <Nothing/> unless visibility.visible

    <div className="layout_loader"></div>

module.exports = Marty.createContainer Loader,
  listenTo: 'loaderVisibilityStore'

  fetch: ->
    visibility: @app.loaderVisibilityStore.get()
