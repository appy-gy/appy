_ = require 'lodash'
React = require 'react'
canEditRating = require '../../helpers/ratings/can_edit'
PaginationLink = require './pagination_link'
Preview = require '../shared/ratings/preview'
CreateRating = require '../shared/ratings/create'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired
    user: PropTypes.object.isRequired
    isOwnPage: PropTypes.bool.isRequired

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

    <div className="user-profile_content">
      <h2 className="user-profile_tab-header">
        Рейтинги
      </h2>
      <div className="previews">
        {@ratings()}
      </div>
      {@noRatings()}
      {@createRating()}
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

module.exports = Ratings
