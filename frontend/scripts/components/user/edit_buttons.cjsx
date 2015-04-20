React = require 'react/addons'
classNames = require 'classnames'
Nothing = require '../shared/nothing'

{PropTypes} = React

EditButtons = React.createClass
  displayName: 'EditButtons'

  propTypes:
    start: PropTypes.func.isRequired
    save: PropTypes.func.isRequired
    cancel: PropTypes.func.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  buttonTypes: [
    { action: 'start', onEdit: false }
    { action: 'cancel', onEdit: true }
    { action: 'save', onEdit: true }
  ]

  buttons: ->
    {edit} = @context

    @buttonTypes.map ({action, onEdit}) =>
      return unless edit == onEdit

      classes = classNames 'user-profile_edit-button', "m-#{action}"
      onClick = @props[action]

      <div key={action} className={classes} onClick={onClick}></div>

  render: ->
    {user} = @context

    return <Nothing/> unless user.canEdit

    <div className="user-profile_edit-buttons">
      {@buttons()}
    </div>

module.exports = EditButtons
