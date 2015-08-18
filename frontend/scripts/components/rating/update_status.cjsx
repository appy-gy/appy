React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

UpdateStatus = React.createClass
  displayName: 'UpdateStatus'

  propTypes:
    status: PropTypes.object.isRequired

  statusNames:
    done: 'Сохранено'
    pending: 'Ожидает сохранения...'
    saving: 'Сохраняется...'

  render: ->
    {status} = @props

    name = @statusNames[status.type]

    <div className="header_rating-update-status #{status.type}">
      {name}
    </div>

module.exports = Marty.createContainer UpdateStatus,
  listenTo: 'ratingUpdateStatusStore'

  fetch: ->
    status: @app.ratingUpdateStatusStore.get()
