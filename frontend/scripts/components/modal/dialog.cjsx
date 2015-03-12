React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Dialog = React.createClass
  displayName: 'Dialog'

  mixins: [PureRenderMixin]

  propTypes:
    title: PropTypes.string.isRequired
    show: PropTypes.bool.isRequired
    onHide: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  render: ->
    {title, show, onHide, children} = @props

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
