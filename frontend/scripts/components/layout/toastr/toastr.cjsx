React = require 'react/addons'
Marty = require 'marty'
Toast = require './toast'
ToastsStore = require '../../../stores/toasts'

{PropTypes} = React

Toastr = React.createClass
  displayName: 'Toastr'

  propTypes:
    toasts: PropTypes.arrayOf(PropTypes.object).isRequired

  toasts: ->
    {toasts} = @props

    toasts.map (toast) ->
      <Toast key={toast.cid} toast={toast}

  render: ->
    <div className="toastr">
      {@toasts()}
    </div>

module.exports = Marty.createContainer Toastr,
  listenTo: ToastsStore

  fetch: ->
    toasts: ToastsStore.for(@).getAll()
