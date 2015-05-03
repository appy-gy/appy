_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Comment = require '../shared/comments/comment'
CommentsStore = require '../../stores/comments'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  noComments: ->
    {comments} = @props

    return unless _.isEmpty comments

    <div>
      У вас пока нет комментариев.
    </div>

  comments: ->
    {comments} = @props

    comments.map (comment) ->
      <Comment key={comment.id} comment={comment}/>

  render: ->
    {comments} = @props

    <div>
      <h2 className="user-profile_tab-header">
        Ваши комментарии ({comments.length})
      </h2>
      {@noComments}
      {@comments()}
    </div>

module.exports = Marty.createContainer Comments,
  contextTypes:
    user: PropTypes.object.isRequired

  listenTo: CommentsStore

  fetch: ->
    {user} = @context

    comments: CommentsStore.for(@).getForUser(user.id)
