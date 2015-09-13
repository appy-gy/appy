React = require 'react/addons'
ReactRedux = require 'react-redux'
similarRatingActions = require '../../actions/similar_ratings'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchSimilarRatings} = similarRatingActions

Similar = React.createClass
  displayName: 'Similar'

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    rating: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchSimilarRatings()

  fetchSimilarRatings: ->
    @props.dispatch fetchSimilarRatings()

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

mapStateToProps = ({similarRatings}) ->
  ratings: similarRatings.items

module.exports = connect(mapStateToProps)(Similar)
