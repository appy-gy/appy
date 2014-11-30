React = require 'react/addons'

ModalDialog = React.createClass
  getInitialState: ->
    show: false

  showDialog: ->
    @setState show: true

  hideDialog: ->
    @setState show: false

  render: ->
    if @state.show
      <div className="modal-dialog-wrapper">
        <div className="modal-dialog">
          <a onClick={@hideDialog} className="modal-dialog-close">&times;</a>
          <div className="modal-dialog-title">{@props.title}</div>
          <div className="modal-dialog-body">{@props.children}</div>
        </div>
        <div className="modal-dialog-bg"></div>
      </div>
    else
      null

module.exports = ModalDialog
