React = require 'react'
ReactRedux = require 'react-redux'
userCommentActions = require '../../actions/user_comments'
Watch = require '../mixins/watch'
PaginationLink = require './pagination_link'
Comment = require '../shared/comments/comment'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React
{connect} = ReactRedux
{fetchUserComments, clearUserComments} = userCommentActions

Comments = React.createClass
  displayName: 'Comments'

  mixins: [Watch]

  propTypes:
    dispatch: PropTypes.func.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchComments()

    @watch
      exp: => @props.page
      onChange: @fetchComments

    @watch
      exp: => @context.currentUser.id
      onChange: =>
        @clearComments()
        @fetchComments()

  fetchComments: ->
    @props.dispatch fetchUserComments(@props.page, @context.user.id)

  clearComments: ->
    @props.dispatch clearUserComments()

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

    <div>
      <h2 className="user-profile_tab-header">
        Комментарии к рейтингам ({user.commentsCount})
      </h2>
      {@noComments()}
      {@comments()}
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </div>

mapStateToProps = ({userComments}) ->
  comments: userComments.items, pagesCount: userComments.pagesCount

module.exports = connect(mapStateToProps)(Comments)
