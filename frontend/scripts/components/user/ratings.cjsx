_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
canEditRating = require '../../helpers/ratings/can_edit'
PaginationLink = require './pagination_link'
Preview = require '../shared/ratings/preview'
CreateRating = require '../shared/ratings/create'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  propTypes:
    currentUser: PropTypes.object.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    isOwnPage: PropTypes.bool.isRequired

  hasRatings: ->
    {user} = @context

    user.ratingsCount > 0

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
    {currentUser, ratings} = @props

    ratings.map (rating) ->
      showDelete = canEditRating currentUser, rating
      <Preview key={rating.id} rating={rating} mod={rating.status} imageSize="preview" showDelete={showDelete}/>

  render: ->
    {page} = @props
    {user} = @context

    pagesCount = @app.pageCountsStore.get("userRatings") || 0

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

module.exports = Marty.createContainer Ratings,
  listenTo: ['currentUserStore', 'ratingsStore']

  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    userSlug: PropTypes.string.isRequired

  fetch: ->
    {page} = @props
    {userSlug} = @context

    currentUser: @app.currentUserStore.get()
    ratings: @app.ratingsStore.getForUser(userSlug, page)
