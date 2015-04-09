_ = require 'lodash'
React = require 'react/addons'
isBlank = require '../../helpers/is_blank'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

Name = React.createClass
  displayName: 'Name'

  contextTypes:
    user: PropTypes.object.isRequired

  getInitialState: ->
    {user} = @context

    edit: isBlank(user.name)

  startEdit: ->
    @setState edit: true

  saveUser: ->
    {user} = @context

    UserActionCreators.update user.id, name: user.name

  changeName: (event) ->
    {user} = @context
    {value} = event.target

    return if isBlank value

    UserActionCreators.change user.id, name: value

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

    <input type="text" autoFocus={true} placeholder="Введи свое имя" value={user.name} onChange={@changeName} onBlur={@saveUser}/>

  render: ->
    {user} = @context

    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = Name
