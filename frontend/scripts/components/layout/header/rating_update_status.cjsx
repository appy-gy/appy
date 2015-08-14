React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

RatingUpdateStatus = React.createClass
  displayName: 'RatingUpdateStatus'

  propTypes:
    status: PropTypes.object.isRequired

  statusNames:
    done: 'Сохранено'
    pending: 'Ожидает сохранения'
    saving: 'Сохраняется'

  render: ->
    {status} = @props

    name = @statusNames[status.type]

    <div className="header_rating-update-status #{status.type}">
      {name}
    </div>

module.exports = Marty.createContainer RatingUpdateStatus,
  listenTo: 'ratingUpdateStatusStore'

  fetch: ->
    status: @app.ratingUpdateStatusStore.get()
