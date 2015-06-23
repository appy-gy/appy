React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired

  contextTypes:
    canEdit: PropTypes.bool.isRequired

  childContextTypes:
    ratingItem: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingItem} = @props

    { ratingItem, block: 'rating-item' }

  removeItem: ->
    {ratingItem} = @props

    @app.ratingItemsActions.remove ratingItem.id

  removeButton: ->
    {canEdit} = @context

    return unless canEdit

    <div className="rating-item_remove" onClick={@removeItem}>
      Удалить
    </div>

  render: ->
    {ratingItem, index} = @props

    <section className="rating-item">
      {@removeButton()}
      <div className="rating-item_header">
        <Title object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <Image/>
      <div className="rating-item_description-wrapper">
        <Description object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <Votes/>
    </section>

module.exports = RatingItem
