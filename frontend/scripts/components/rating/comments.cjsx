React = require 'react/addons'
Marty = require 'marty'
Comment = require './comment'
CommentForm = require './comment_form'
CommentsStore = require '../../stores/comments'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  comments: ->
    {comments} = @props

    comments.map (comment) ->
      <Comment key={comment.id} comment={comment}/>

  render: ->
    <div className="comments">
      <div className="comments_header">
        Комментарии
      </div>
      {@comments()}
      <CommentForm/>
    </div>

module.exports = Marty.createContainer Comments,
  contextTypes:
    rating: PropTypes.object.isRequired

  listenTo: CommentsStore

  fetch: ->
    {rating} = @context

    comments: CommentsStore.for(@).getForRating(rating.id)
