React = require 'react/addons'
Marty = require 'marty'
Classes = require '../mixins/classes'

{PropTypes} = React

AddRatingItem = React.createClass
  displayName: 'AddRatingItem'

  mixins: [Marty.createAppMixin(), Classes]

  propTypes:
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
    {position} = @props
    {rating} = @context

    @app.ratingsActions.changePositions @newPositions()
    @app.ratingItemsActions.create rating.id, position

  render: ->
    {children} = @props

    <div className={@classes()} onClick={@createRatingItem}>
      {children}
    </div>

module.exports = AddRatingItem
