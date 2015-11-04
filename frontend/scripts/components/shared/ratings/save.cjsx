React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
classNames = require 'classnames'
RatingUpdater = require '../../mixins/rating_updater'

{PropTypes} = React
{connect} = ReactRedux
{updateRating} = ratingActions

SaveRating = React.createClass
  displayName: 'SaveRating'

  mixins: [RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  statusNames:
    done: 'Сохранить'
    pending: 'Ожидает сохранения...'
    saving: 'Сохраняется...'

  saveRating: ->
    @performSave()

  render: ->
    {status} = @props
    {block} = @context

    classes = classNames 'm-disabled': status != 'done'

    <div className="rating-statusbar_link #{classes}" onClick={@saveRating}>{@statusNames[status]}</div>

mapStateToProps = ({rating}) ->
  status: rating.updateStatus

module.exports = connect(mapStateToProps)(SaveRating)
