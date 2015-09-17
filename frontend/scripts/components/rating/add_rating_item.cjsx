_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingItemActions = require '../../actions/rating_items'
Classes = require '../mixins/classes'

{PropTypes} = React
{connect} = ReactRedux
{createRatingItem, changeRatingItemPositions} = ratingItemActions

AddRatingItem = React.createClass
  displayName: 'AddRatingItem'

  mixins: [Classes]

  propTypes:
    dispatch: PropTypes.func.isRequired
    position: PropTypes.number.isRequired
    children: PropTypes.node

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  getDefaultProps: ->
    children: null

  newPositions: ->
    {position} = @props
    {ratingItems} = @context

    _.transform ratingItems, (result, {id, position: pos}) ->
      result[id] = if pos >= position then pos + 1 else pos
    , {}

  createRatingItem: ->
    {dispatch, position} = @props

    dispatch changeRatingItemPositions(@newPositions())
    dispatch createRatingItem(position)

  render: ->
    {children} = @props

    props = _.omit @props, 'position', 'children'

    <div className={@classes()} onClick={@createRatingItem} {...props}>
      {children}
    </div>

module.exports = connect()(AddRatingItem)
