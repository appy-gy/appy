React = require 'react/addons'
moment = require 'moment'
shortId = require '../../../helpers/short_id'
imageUrl = require '../../../helpers/image_url'
ScrollTo = require '../../mixins/scroll_to'
Actions = require './actions'
UserLink = require '../links/user'

{PropTypes} = React

Comment = React.createClass
  displayName: 'Comment'

  mixins: [ScrollTo]

  propTypes:
    comment: PropTypes.object.isRequired
    actionTypes: PropTypes.object.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    comment: PropTypes.object.isRequired

  getChildContext: ->
    {comment} = @props

    { comment }

  componentDidMount: ->
    {comment} = @props
    {router} = @context

    return unless shortId(comment.id) == router.getCurrentQuery().comment
    @scrollTo()

  render: ->
    {comment, actionTypes} = @props

    <div className="comment">
      <UserLink className="comment_username" user={comment.user}>
        <img className="comment_userface" src={imageUrl comment.user.avatar, 'small'}/>
      </UserLink>
      <div className="comment_content">
        <UserLink className="comment_username" user={comment.user}>
          {comment.user.name or comment.user.email}
        </UserLink>
        <span className="comment_text">
          {comment.body}
        </span>
        <div className="comment_date">
          {moment(comment.createdAt).fromNow()}
        </div>
        <Actions ref="actions" types={actionTypes}/>
      </div>
    </div>

module.exports = Comment
