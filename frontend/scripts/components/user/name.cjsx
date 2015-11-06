_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React
{connect} = ReactRedux
{changeUser, updateUser} = userActions

Name = React.createClass
  displayName: 'Name'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  placeholder: 'Введи свое имя'

  getInitialState: ->
    edit: @context.canEdit and isBlank(@context.user.name)

  changeName: (event) ->
    @props.dispatch changeUser(name: event.target.value)

  saveName: ->
    {dispatch} = @props
    {user} = @context

    @setState edit: false
    return dispatch changeUser(name: @prevName) if isBlank user.name
    dispatch updateUser(name: user.name)

  startEdit: ->
    {user, canEdit} = @context

    return unless canEdit

    @prevName = user.name
    @setState edit: true

  cancelEdit: ->
    {dispatch} = @props
    {user} = @context

    @setState edit: false
    dispatch changeUser(name: @prevName)

  onKeyDown: (event) ->
    return @cancelEdit() if event.keyCode == 27
    return event.target.blur() if event.keyCode == 13

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

    <input className="user-profile_name-value" type="text" autoFocus placeholder={@placeholder} value={user.name} onChange={@changeName} onBlur={@saveName} onKeyDown={@onKeyDown}/>

  render: ->
    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = connect()(Name)
