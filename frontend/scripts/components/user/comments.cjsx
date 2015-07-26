React = require 'react/addons'
Marty = require 'marty'
PaginationLink = require './pagination_link'
Comment = require '../shared/comments/comment'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    page: PropTypes.number.isRequired

  noComments: ->
    {user} = @context

    return if user.commentsCount > 0

    <div>
      У вас пока нет комментариев.
    </div>

  comments: ->
    {comments} = @props

    actionTypes = open: {}, answer: { inline: false }

    comments.map (comment) ->
      <Comment key={comment.id} comment={comment} actionTypes={actionTypes}/>

  render: ->
    {user, page} = @context

    pagesCount = @app.pageCountsStore.get('userComments') || 0

    <div>
      <h2 className="user-profile_tab-header">
        Комментарии к рейтингам ({user.commentsCount})
      </h2>
      {@noComments()}
      {@comments()}
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

module.exports = Marty.createContainer Comments,
  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  listenTo: 'commentsStore'

  fetch: ->
    {page} = @props
    {user} = @context

    comments: @app.commentsStore.getForUser(user.id, page)
