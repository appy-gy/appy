_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
Classes = require '../mixins/classes'
RatingUpdater = require '../mixins/rating_updater'
Editor = require '../shared/inputs/editor'

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

  editorOptions: ->
    {placeholder} = @props

    placeholder:
      text: placeholder

  changeDescription: (description) ->
    {dispatch, object, objectType, passObjectId} = @props

    payload = [{ description }]
    payload.unshift object.id if passObjectId

    dispatch actions[objectType].change(payload...)
    @queueUpdate =>
      dispatch actions[objectType].update(payload..., true)

  description: ->
    {object, edit, placeholder} = @props
    {block} = @context

    if edit
      <div>
        <Editor className={@classes("#{block}_description", 'm-edit')} value={object.description} onChange={@changeDescription} options={@editorOptions()}/>
      </div>
    else
      <div className={@classes("#{block}_description")}>
        <div dangerouslySetInnerHTML={__html: object.description}></div>
      </div>

  render: ->
    {block} = @context

    <div className="#{block}_description-wrapper">
      {@description()}
    </div>

module.exports = connect()(Description)
