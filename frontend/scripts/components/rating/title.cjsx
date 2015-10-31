_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'

{PropTypes} = React
{connect} = ReactRedux
{changeRating, updateRating} = ratingActions
{changeRatingItem, updateRatingItem} = ratingItemActions

actions =
  rating:
    change: changeRating
    update: updateRating
  ratingItem:
    change: changeRatingItem
    update: updateRatingItem

Title = React.createClass
  displayName: 'Title'

  mixins: [PureRendexMixin, Classes, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    object: PropTypes.object.isRequired
    objectType: PropTypes.string.isRequired
    passObjectId: PropTypes.bool.isRequired
    edit: PropTypes.bool.isRequired
    placeholder: PropTypes.string.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  restrictEnter: (event) ->
    return unless event.key == 'Enter'
    event.preventDefault()

  changeTitle: (event) ->
    {dispatch, object, objectType, passObjectId} = @props

    title = event.target.value
    payload = [{ title }]
    payload.unshift object.id if passObjectId

    dispatch actions[objectType].change(payload...)
    @queueUpdate =>
      dispatch actions[objectType].update(payload..., true)

  title: ->
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <Textarea maxLength="90" className={@classes("#{block}_title", 'm-edit')} placeholder={placeholder} value={object.title} onChange={@changeTitle} onKeyDown={@restrictEnter}/>
    else
      <h1 className={@classes("#{block}_title")}>
        {object.title}
      </h1>

  render: ->
    {object} = @props
    {block} = @context

    <div className="#{block}_title-wrapper">
      {@title()}
    </div>

module.exports = connect()(Title)
