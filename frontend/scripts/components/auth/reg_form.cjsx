React = require 'react/addons'

RegForm = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  getInitialState: ->
    email: null, password: null

  handleSubmit: (event) ->
    event.preventDefault()
    {email, password} = @state
    return unless email? and password?
    @props.onRegFormSubmit { email, password }

  render: ->
    <form className="reg-form" onSubmit={@handleSubmit}>
      <input type="text" placeholder="email" valueLink={@linkState 'email'} />
      <input type="password" placeholder="password" valueLink={@linkState 'password'} />
      <input type="submit" value="Registration" />
    </form>

module.exports = RegForm
