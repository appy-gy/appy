_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

Name = React.createClass
  displayName: 'Name'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  placeholder: 'Введи свое имя'

  getInitialState: ->
    {user, canEdit} = @context

    edit: canEdit and isBlank(user.name)

  changeName: (event) ->
    {user} = @context
    {value} = event.target

    @app.usersActions.change user.id, name: value

  saveName: ->
    {user} = @context

    @setState edit: false
    return @app.usersActions.change user.id, name: @prevName if isBlank user.name
    @app.usersActions.update user.id, name: user.name

  startEdit: ->
    {user, canEdit} = @context

    return unless canEdit

    @prevName = user.name
    @setState edit: true

  cancelEdit: ->
    {user} = @context

    @setState edit: false
    @app.usersActions.change user.id, name: @prevName

  contentView: ->
    {edit} = @state
    {user} = @context

    return if edit

    <div className="user-profile_name-value" onClick={@startEdit}>
      {user.name || @placeholder}
    </div>

  contentEdit: ->
    {edit} = @state
    {user} = @context

    return unless edit

    withIndexKeys [
      <input className="user-profile_name-value" type="text" autoFocus placeholder={@placeholder} value={user.name} onChange={@changeName}/>
      <div className="user-profile_name-buttons">
        <div className="user-profile_name-button m-accept" onClick={@saveName}>
          Cохранить
        </div>
        <div className="user-profile_name-button m-cancel" onClick={@cancelEdit}>
        </div>
      </div>
    ]

  render: ->
    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = Name
