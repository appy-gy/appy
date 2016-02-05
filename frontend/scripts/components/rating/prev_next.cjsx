_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
imageUrl = require '../../helpers/image_url'
prevNextRatingActions = require '../../actions/prev_next_ratings'
RatingLink = require '../shared/links/rating'

{PropTypes} = React
{connect} = ReactRedux
{fetchPrevNextRatings} = prevNextRatingActions

PrevNext = React.createClass
  displayName: 'PrevNext'

  mixins: [PureRendexMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    rating: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchPrevNextRatings()

  fetchPrevNextRatings: ->
    @props.dispatch fetchPrevNextRatings(@props.rating.slug)

  ratings: ->
    {ratings} = @props

    return if _.isEmpty ratings

    ['prev', 'next'].map (mod, index) =>
      rating = ratings[index]
      @rating rating, mod

  rating: (rating, mod) ->
    styles = backgroundImage: "url(#{imageUrl(rating.image, 'normal')})"

    <RatingLink key={mod} className="prev-next_item" rating={rating} style={styles}>
      <div className="prev-next_content">
        <div className="prev-next_arrow m-#{mod}"></div>
        <div className="prev-next_title">{rating.title}</div>
      </div>
    </RatingLink>

  render: ->
    <div className="prev-next">
      {@ratings()}
    </div>

mapStateToProps = ({prevNextRatings}) ->
  ratings: prevNextRatings.items

module.exports = connect(mapStateToProps)(PrevNext)
