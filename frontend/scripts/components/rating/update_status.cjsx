React = require 'react'
ReactRedux = require 'react-redux'

{PropTypes} = React
{connect} = ReactRedux

UpdateStatus = React.createClass
  displayName: 'UpdateStatus'

  propTypes:
    status: PropTypes.string.isRequired

  statusNames:
    done: 'Сохранено'
    pending: 'Ожидает сохранения...'
    saving: 'Сохраняется...'

  render: ->
    {status} = @props

    name = @statusNames[status]

    <div className="header_rating-update-status m-#{status}">
      {name}
    </div>

mapStateToProps = ({rating}) ->
  status: rating.updateStatus

module.exports = connect(mapStateToProps)(UpdateStatus)
