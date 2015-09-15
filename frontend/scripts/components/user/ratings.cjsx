_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
userRatingActions = require '../../actions/user_ratings'
canEditRating = require '../../helpers/ratings/can_edit'
Watch = require '../mixins/watch'
PaginationLink = require './pagination_link'
Preview = require '../shared/ratings/preview'
CreateRating = require '../shared/ratings/create'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React
{connect} = ReactRedux
{fetchUserRatings, clearUserRatings} = userRatingActions

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Watch]

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired
    user: PropTypes.object.isRequired
    isOwnPage: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchRatings()

    @watch
      exp: => @props.page
      onChange: @fetchRatings

    @watch
      exp: => @context.currentUser.id
      onChange: =>
        @clearRatings()
        @fetchRatings()

  fetchRatings: ->
    @props.dispatch fetchUserRatings(@props.page, @context.user.id)

  clearRatings: ->
    @props.dispatch clearUserRatings()

  hasRatings: ->
    @context.user.ratingsCount > 0

  noRatings: ->
    {isOwnPage} = @context

    return if @hasRatings()

    text = if isOwnPage then 'У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!' else 'У пользователя нет рейтингов.'

    <div className="user-profile_tab-no-ratings">
      {text}
    </div>

  createRating: ->
    {isOwnPage} = @context

    return if @hasRatings() or not isOwnPage

    <CreateRating className="user-profile_tab-button">
      Создать рейтинг
    </CreateRating>

  ratings: ->
    {ratings, page} = @props
    {currentUser} = @context

    ratings
      .filter (rating) -> rating.page == page
      .map (rating) ->
        showDelete = canEditRating currentUser, rating
        <Preview key={rating.id} rating={rating} mod={rating.status} imageSize="preview" showDelete={showDelete}/>

  render: ->
    {page, pagesCount} = @props
    {user} = @context

    <div>
      <h2 className="user-profile_tab-header">
        Рейтинги ({user.ratingsCount})
      </h2>
      <div className="previews">
        {@ratings()}
      </div>
      {@noRatings()}
      {@createRating()}
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

mapStateToProps = ({userRatings}) ->
  ratings: userRatings.items, pagesCount: userRatings.pagesCount

module.exports = connect(mapStateToProps)(Ratings)
