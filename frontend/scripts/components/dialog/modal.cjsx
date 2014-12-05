React = require 'react/addons'

ModalDialog = React.createClass
  render: ->
    {title, children, show, onHide} = @props

    return <div></div> unless show

    <div className="modal-dialog-wrapper">
      <div className="modal-dialog">
        <a onClick={onHide} className="modal-dialog-close">&times;</a>
        <div className="modal-dialog-title">{title}</div>
        <div className="modal-dialog-body">{children}</div>
      </div>
      <div className="modal-dialog-bg"></div>
    </div>

module.exports = ModalDialog
