React = require 'react/addons'
Marty = require 'marty'
Preview = require '../shared/ratings/preview'

{PropTypes} = React

Similar = React.createClass
  displayName: 'Similar'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  ratings: ->
    {ratings} = @props

    ratings.map (rating) ->
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    <div className="similar">
      <div className="similar_title">
        А еще вот что:
      </div>
      <div className="previews">
        {@ratings()}
      </div>
    </div>

module.exports = Marty.createContainer Similar,
  listenTo: ['similarRatingsStore']

  contextTypes:
    ratingSlug: PropTypes.string.isRequired

  fetch: ->
    {ratingSlug} = @context

    ratings: @app.similarRatingsStore.getFor(ratingSlug)
