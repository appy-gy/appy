_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
isBlank = require '../../helpers/is_blank'
withIndexKeys = require '../../helpers/react/with_index_keys'

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

module.exports = connect()(Name)
