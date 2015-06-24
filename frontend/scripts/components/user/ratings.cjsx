React = require 'react/addons'
Marty = require 'marty'
PaginationLink = require './pagination_link'
Preview = require '../shared/ratings/preview'
CreateRating = require '../shared/ratings/create'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    user: PropTypes.object.isRequired
    page: PropTypes.number.isRequired

  noRatings: ->
    return if @hasRatings()

    <div>
      У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!
    </div>

  createRating: ->
    {user} = @context

    return if @hasRatings()

    <CreateRating className="user-profile_tab-button">
      Создать рейтинг
    </CreateRating>

  hasRatings: ->
    {user} = @context

    user.ratingsCount > 0

  ratings: ->
    {ratings} = @props
    {user} = @context

    ratings.map (rating) ->
      <Preview key={rating.id} rating={rating} imageSize="preview" showDelete={user.canEdit}/>

  render: ->
    {user, page} = @context

    pagesCount = @app.pageCountsStore.get('userRatings') || 0

    <div>
      <h2 className="user-profile_tab-header">
        Ваши рейтинги ({user.ratingsCount})
      </h2>
      {@noRatings()}
      {@createRating()}
      <div className="previews">
        {@ratings()}
      </div>
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

module.exports = Marty.createContainer Ratings,
  listenTo: 'ratingsStore'

  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    userSlug: PropTypes.string.isRequired

  fetch: ->
    {page} = @props
    {userSlug} = @context

    ratings: @app.ratingsStore.getForUser(userSlug, page)
