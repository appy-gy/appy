React = require 'react/addons'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

Name = React.createClass
  displayName: 'Name'

  contextTypes:
    user: PropTypes.object.isRequired

  getInitialState: ->
    edit: false

  startEdit: ->
    @setState edit: true

  saveUser: ->
    {user} = @context

    UserActionCreators.update user.id, name: user.name

  changeName: (event) ->
    {user} = @context

    UserActionCreators.change user.id, name: event.target.value

  contentView: ->
    {edit} = @state
    {user} = @context

    return if edit

    <div onClick={@startEdit}>
      {user.name}
    </div>

  contentEdit: ->
    {edit} = @state
    {user} = @context

    return unless edit

    <input autoFocus={true} type="text" value={user.name} onChange={@changeName} onBlur={@saveUser}/>

  render: ->
    {user} = @context

    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = Name
