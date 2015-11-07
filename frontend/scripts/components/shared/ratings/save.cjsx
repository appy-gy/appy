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
    pending: 'Сохраняем...'
    saving: 'Сохраняем...'
    rejected: 'Ошибка'

  saveRating: ->
    @performSave()

  render: ->
    {status} = @props
    {block} = @context

    classes = classNames 'm-disabled': status != 'done', "m-#{status}"

    <div className="rating-statusbar_save-button #{classes}" onClick={@saveRating}>{@statusNames[status]}</div>

mapStateToProps = ({rating}) ->
  status: rating.updateStatus

module.exports = connect(mapStateToProps)(SaveRating)
