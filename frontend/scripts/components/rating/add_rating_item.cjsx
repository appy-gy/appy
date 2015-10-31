_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingItemActions = require '../../actions/rating_items'
Classes = require '../mixins/classes'

{PropTypes} = React
{connect} = ReactRedux
{createRatingItem, changeRatingItemPositions} = ratingItemActions

AddRatingItem = React.createClass
  displayName: 'AddRatingItem'

  mixins: [PureRendexMixin, Classes]

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    position: PropTypes.number.isRequired
    children: PropTypes.node

  getDefaultProps: ->
    children: null

  newPositions: ->
    {ratingItems, position} = @props

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
