React = require 'react'
PaginationLink = require './pagination_link'
Comment = require '../shared/comments/comment'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    comments: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  noComments: ->
    {user} = @context

    return if user.commentsCount > 0

    <div className="user-profile_tab-no-comments">
      У вас пока нет комментариев.
    </div>

  comments: ->
    {comments, page} = @props

    actionTypes = open: {}, answer: { inline: false }

    comments
      .filter (comment) -> comment.page == page
      .map (comment) ->
        <Comment key={comment.id} comment={comment} showUsername={false} showRatingInfo={true} actionTypes={actionTypes}/>

  render: ->
    {page, pagesCount} = @props
    {user} = @context

    <div className="user-profile_content">
      <h2 className="user-profile_tab-header">
        Комментарии к рейтингам
      </h2>
      {@noComments()}
      {@comments()}
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

module.exports = Comments
