React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin, LinkedStateMixin} = React.addons

LoginForm = React.createClass
  displayName: 'LoginForm'

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

    return unless email? and password?
    onSubmit { email, password }

  render: ->
    <form className="login-form" onSubmit={@onSubmit}>
      <input type="text" placeholder="email" valueLink={@linkState 'email'}/>
      <input type="password" placeholder="password" valueLink={@linkState 'password'}/>
      <input type="submit" value="Login"/>
    </form>

module.exports = LoginForm
