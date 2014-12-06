React = require 'react/addons'

LoginForm = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    email: null, password: null

  handleSubmit: (event) ->
    event.preventDefault()
    {email, password} = @state
    return unless email? and password?
    @props.onLoginFormSubmit { email, password }

  render: ->
    <form className="login-form" onSubmit={@handleSubmit}>
      <input type="text" placeholder="email" valueLink={@linkState 'email'}/>
      <input type="password" placeholder="password" valueLink={@linkState 'password'}/>
      <input type="submit" value="Login"/>
    </form>

module.exports = LoginForm
