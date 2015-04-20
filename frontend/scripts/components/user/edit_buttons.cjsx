React = require 'react/addons'
Nothing = require '../shared/nothing'

{PropTypes} = React

EditButtons = React.createClass
  displayName: 'EditButtons'

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired
    startEdit: PropTypes.func.isRequired
    saveUser: PropTypes.func.isRequired
    cancelEdit: PropTypes.func.isRequired

  startButton: ->
    {edit, startEdit} = @context

    return if edit

    <div className="user-profile_edit-button m-start" onClick={startEdit}></div>

  cancelButton: ->
    {edit, cancelEdit} = @context

    return unless edit

    <div className="user-profile_edit-button m-cancel" onClick={cancelEdit}></div>

  saveButton: ->
    {edit, saveUser} = @context

    return unless edit

    <div className="user-profile_edit-button m-save" onClick={saveUser}></div>

  render: ->
    {user} = @context

    return <Nothing/> unless user.canEdit

    <div className="user-profile_edit-buttons">
      {@startButton()}
      {@cancelButton()}
      {@saveButton()}
    </div>

module.exports = EditButtons
