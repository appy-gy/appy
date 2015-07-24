_ = require 'lodash'
Marty = require 'marty'
React = require 'react/addons'
classNames = require 'classnames'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'

{PropTypes} = React

Publish = React.createClass
  displayName: 'Publish'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  hasPublishErrors: ->
    {rating, ratingItems} = @props

    not _.isEmpty prepublishValidation(rating, ratingItems)

  publish: ->
    {rating} = @props

    return unless _.isEmpty @hasPublishErrors()

    @app.ratingsActions.update(rating.id, status: 'published')

  render: ->
    {block} = @context

    classes = classNames "#{block}_publish-rating", 'm-disabled': @hasPublishErrors()

    <div className={classes} onClick={@publish}>
      Опубликовать
    </div>

module.exports = Publish
