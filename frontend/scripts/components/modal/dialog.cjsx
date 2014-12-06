React = require 'react/addons'

Dialog = React.createClass
  render: ->
    {title, children, show, onHide} = @props

    return <div></div> unless show

    <div className="modal">
      <div className="modal_body">
        <a className="modal_close" onClick={onHide}>&times;</a>
        <div className="modal_title">{title}</div>
        <div className="modal_body">{children}</div>
      </div>
      <div className="modal_background"></div>
    </div>

module.exports = Dialog
