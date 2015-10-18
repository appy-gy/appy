React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
classNames = require 'classnames'

{PropTypes} = React
{connect} = ReactRedux
{updateRating} = ratingActions

SaveRating = React.createClass
  displayName: 'SaveRating'

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  saveRating: ->
    {dispatch, rating} = @props
    console.log 'save'

  render: ->
    {status} = @props
    {block} = @context

    classes = classNames 'm-disabled': status != 'done'

    <div className="#{block}_save-rating #{classes}" onClick={@saveRating}>Сохранить</div>

mapStateToProps = ({rating}) ->
  status: rating.updateStatus

module.exports = connect(mapStateToProps)(SaveRating)
