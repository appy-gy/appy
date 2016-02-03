React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
prevNextRatingActions = require '../../actions/prev_next_ratings'

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

  render: ->
    <div className="prev-next">
      <div className="prev-next_item">
        <div className="prev-next_content">
          <div className="prev-next_arrow m-prev"></div>
          <div className="prev-next_title">Шесть советов начинающим косплеерам</div>

        </div>
      </div>
      <div className="prev-next_item">
        <div className="prev-next_content">
          <div className="prev-next_arrow m-next"></div>
          <div className="prev-next_title">Шесть советов начинающим косплеерам</div>
        </div>
      </div>
    </div>

mapStateToProps = ({prevNextRatings}) ->
  ratings: prevNextRatings.items

module.exports = connect(mapStateToProps)(PrevNext)
