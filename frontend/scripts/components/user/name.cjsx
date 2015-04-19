_ = require 'lodash'
React = require 'react/addons'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

Name = React.createClass
  displayName: 'Name'

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  changeName: (event) ->
    {user} = @context
    {value} = event.target

    UserActionCreators.change user.id, name: value

  contentView: ->
    {user, edit} = @context

    return if edit

    user.name

  contentEdit: ->
    {user, edit} = @context

    return unless edit

    <input type="text" autoFocus={true} placeholder="Введи свое имя" value={user.name} onChange={@changeName}/>

  render: ->
    <div className="user-profile_name">
      {@contentView()}
      {@contentEdit()}
    </div>

module.exports = Name
