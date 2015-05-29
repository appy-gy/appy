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

    edit: isBlank(user)

  changeName: (event) ->
    {user} = @context
    {value} = event.target

    UserActionCreators.change user.id, name: value

  saveName: ->
    {user} = @context

    @setState edit: false
    return UserActionCreators.change user.id, name: @prevName if isBlank user.name
    UserActionCreators.update user.id, name: user.name

  startEdit: ->
    {user} = @context

    @prevName = user.name
    @setState edit: true

  cancelEdit: ->
    {user} = @context

    UserActionCreators.change user.id, name: @prevName
    @setState edit: false

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

    <div>
      <input type="text" autoFocus={true} placeholder="Введи свое имя" value={user.name} onChange={@changeName}/>
      <div className="user-profile_name-buttons">
        <div className="user-profile_name-button m-accept" onClick={@saveName}>
          Cохранить
        </div>
        <div className="user-profile_name-button m-cancel" onClick={@cancelEdit}>
          Отменить
        </div>
      </div>
    </div>

  render: ->
    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = Name
