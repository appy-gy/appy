_ = require 'lodash'
React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin, LinkedStateMixin} = React.addons

Form = React.createClass
  displayName: 'Form'

  mixins: [PureRenderMixin, LinkedStateMixin]

  propTypes:
    onSubmit: PropTypes.func.isRequired

  getInitialState: ->
    email: ''
    password: ''

  onSubmit: (event) ->
    {onSubmit} = @props
    {email, password} = @state

    event.preventDefault()

    onSubmit { email, password }

  render: ->
    <form className="auth-popup_form" onSubmit={@onSubmit}>
      <input type="text" className="auth-popup_input" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
      <input type="password" className="auth-popup_input" placeholder="Пароль" valueLink={@linkState 'password'}/>
      <div className="auth-popup_submit" onClick={@onSubmit}></div>
      <input type="submit" value="" className="g-hidden"/>
    </form>

module.exports = Form
