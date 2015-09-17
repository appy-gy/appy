_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
AutolinkText = require 'react-autolink-text'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Textarea = require '../shared/inputs/text'
removeExtraSpaces = require '../../helpers/remove_extra_spaces'

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

Description = React.createClass
  displayName: 'Description'

  mixins: [Classes, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    object: PropTypes.object.isRequired
    objectType: PropTypes.string.isRequired
    passObjectId: PropTypes.bool.isRequired
    edit: PropTypes.bool.isRequired
    placeholder: PropTypes.string.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  changeDescription: (event) ->
    {dispatch, object, objectType, passObjectId} = @props

    description = event.target.value
    payload = [{ description }]
    payload.unshift object.id if passObjectId

    dispatch actions[objectType].change(payload...)
    @queueUpdate =>
      dispatch actions[objectType].update(payload..., true)

  description: ->
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <Textarea className={@classes("#{block}_description", 'm-edit')} placeholder={placeholder} value={object.description} onChange={@changeDescription}/>
    else
      <div className={@classes("#{block}_description")}>
        <AutolinkText text={removeExtraSpaces(object.description)}></AutolinkText>
      </div>

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@description()}
    </div>

module.exports = connect()(Description)
