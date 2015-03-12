React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin, LinkedStateMixin} = React.addons

RegistrationForm = React.createClass
  displayName: 'RegistrationForm'

  mixins: [PureRenderMixin, LinkedStateMixin]

  propTypes:
    onSubmit: PropTypes.func.isRequired

  getInitialState: ->
    email: ''
    password: ''

  onSubmit: (event) ->
    {email, password} = @state

    event.preventDefault()

    return unless email? and password?
    @props.onSubmit { email, password }

  render: ->
    <form onSubmit={@onSubmit}>
      <input type="text" placeholder="email" valueLink={@linkState 'email'}/>
      <input type="password" placeholder="password" valueLink={@linkState 'password'}/>
      <input type="submit" value="Registration"/>
    </form>

module.exports = RegistrationForm
