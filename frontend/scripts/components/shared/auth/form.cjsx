React = require 'react'

{PropTypes} = React

Form = React.createClass
  displayName: 'Form'

  propTypes:
    onSubmit: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  render: ->
    {onSubmit, children} = @props

    <form className="auth-popup_form" onSubmit={onSubmit}>
      {children}
      <div className="auth-popup_submit" onClick={onSubmit}></div>
      <input type="submit" value="" formNoValidate className="m-hidden"/>
    </form>

module.exports = Form
