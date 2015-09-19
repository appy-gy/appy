React = require 'react'
ReactRedux = require 'react-redux'
moment = require 'moment'
shortId = require '../../../helpers/short_id'
imageUrl = require '../../../helpers/image_url'
ScrollTo = require '../../mixins/scroll_to'
Actions = require './actions'
UserLink = require '../links/user'
RatingLink = require '../links/rating'
SectionLink = require '../links/section'

{PropTypes} = React
{connect} = ReactRedux

Comment = React.createClass
  displayName: 'Comment'

  mixins: [ScrollTo]

  propTypes:
    comment: PropTypes.object.isRequired
    showUsername: PropTypes.bool.isRequired
    showRatingInfo: PropTypes.bool.isRequired
    actionTypes: PropTypes.object.isRequired
    query: PropTypes.object.isRequired

  childContextTypes:
    comment: PropTypes.object.isRequired

  getChildContext: ->
    {comment} = @props

    { comment }

  componentDidMount: ->
    {comment, query} = @props

    return unless shortId(comment.id) == query.comment
    @scrollTo()

  username: ->
    {comment, showUsername} = @props

    return unless showUsername

    <UserLink className="comment_username" user={comment.user}>
      {comment.user.name or comment.user.email}
    </UserLink>

  ratingInfo: ->
    {comment, showRatingInfo} = @props

    return unless showRatingInfo

    sectionStyles = color: comment.rating.section.color

    <div className="comment_rating-info">
      <SectionLink className="comment_rating-info-section" section={comment.rating.section} style={sectionStyles}>
        {comment.rating.section.name}:
      </SectionLink>
      <RatingLink className="comment_rating-info-rating" rating={comment.rating}>
        {comment.rating.title}
      </RatingLink>
    </div>

  render: ->
    {comment, actionTypes} = @props

    <div className="comment">
      <UserLink className="comment_username" user={comment.user}>
        <img className="comment_userface" src={imageUrl comment.user.avatar, 'small'}/>
      </UserLink>
      <div className="comment_content">
        {@username()}
        {@ratingInfo()}
        <span className="comment_text">
          {comment.body}
        </span>
        <div className="comment_date">
          {moment(comment.createdAt).fromNow()}
        </div>
        <Actions ref="actions" types={actionTypes}/>
      </div>
    </div>

mapStateToProps = ({router}) ->
  query: router.location.query || {}

module.exports = connect(mapStateToProps)(Comment)
