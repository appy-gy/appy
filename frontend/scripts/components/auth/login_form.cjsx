React = require 'react/addons'

LoginForm = React.createClass
  handleSubmit: (event) ->
    event.preventDefault()
    email = this.refs.login.getDOMNode().value.trim()
    password = this.refs.password.getDOMNode().value.trim()
    return unless email? && password?
    @props.onLoginFormSubmit({email, password});
    this.refs.login.getDOMNode().value = ''
    this.refs.password.getDOMNode().value = ''

  render: ->
    <form className="login-form" onSubmit={@handleSubmit}>
      <input type="text" placeholder="email" ref="login"/>
      <input type="password" placeholder="password" ref="password" />
      <input type="submit" value="Login" />
    </form>

module.exports = LoginForm
