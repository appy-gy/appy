React = require 'react/addons'
Marty = require 'marty'
Toast = require './toast'

{PropTypes} = React

Toastr = React.createClass
  displayName: 'Toastr'

  propTypes:
    toasts: PropTypes.arrayOf(PropTypes.object).isRequired

  toasts: ->
    {toasts} = @props

    toasts.map (toast) ->
      <Toast key={toast.cid} toast={toast}/>

  render: ->
    <div className="toastr">
      {@toasts()}
    </div>

module.exports = Marty.createContainer Toastr,
  listenTo: 'toastsStore'

  fetch: ->
    toasts: @app.toastsStore.getAll()
