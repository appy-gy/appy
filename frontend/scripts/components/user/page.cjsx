_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Helmet = require 'react-helmet'
userActions = require '../../actions/user'
userRatingActions = require '../../actions/user_ratings'
userCommentActions = require '../../actions/user_comments'
canEditUser = require '../../helpers/users/can_edit'
canSeeRatingDrafts = require '../../helpers/ratings/can_see_drafts'
imageUrl = require '../../helpers/image_url'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
BackgroundUploader = require './background_uploader'
Settings = require './settings'
Ratings = require './ratings'
Comments = require './comments'
Layout = require '../layout/layout'
Tabs = require '../shared/tabs/tabs'
Tab = require '../shared/tabs/tab'
Nothing = require '../shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{fetchUser} = userActions
{fetchUserRatings} = userRatingActions
{fetchUserComments} = userCommentActions

User = React.createClass
  displayName: 'User'

  mixins: [Loading, SyncSlug('user', '/users')]

  propTypes:
    dispatch: PropTypes.func.isRequired
    user: PropTypes.object.isRequired
    userSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired
    page: PropTypes.number.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    ratingPagesCount: PropTypes.number.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired
    commentPagesCount: PropTypes.number.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired

  childContextTypes:
    user: PropTypes.object.isRequired
    userSlug: PropTypes.string.isRequired
    isOwnPage: PropTypes.bool.isRequired
    canEdit: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {user, userSlug} = @props

    { user, userSlug, isOwnPage: @isOwnPage(), canEdit: @canEdit(), block: 'user-profile' }

  componentWillMount: ->
    @fetchUser()
    @fetchRatings()
    @fetchComments()

  componentDidUpdate: ->
    @fetchRatings()
    @fetchComments()
    @fetchUser()

  isLoading: ->
    not @props.isFetched

  isOwnPage: ->
    @context.currentUser.id == @props.user.id

  canEdit: ->
    canEditUser @context.currentUser, @props.user

  fetchUser: ->
    @props.dispatch fetchUser(@props.userSlug)

  fetchRatings: ->
    @props.dispatch fetchUserRatings(@props.userSlug, @props.page)

  fetchComments: ->
    @props.dispatch fetchUserComments(@props.userSlug, @props.page)

  resetPage: (query) ->
    _.omit query, 'page'

  backgroundUploader: ->
    <BackgroundUploader/> if @canEdit()

  settings: ->
    <Settings/> if @canEdit()

  render: ->
    {user, page, ratings, ratingPagesCount, comments, commentPagesCount} = @props

    return <Nothing/> if @isLoading()

    headerStyles = backgroundImage: "url(#{imageUrl user.background, 'normal'})"

    <Layout>
      <Helmet title={user.name}/>
      <div className="user-profile">
        <header className="user-profile_header" style={headerStyles}>
          <Avatar/>
          <div className="user-profile_info">
            <div className="user-profile_name-wrap">
              <Name/>
              {@settings()}
            </div>
            <SocialButtons/>
          </div>
          <div className="user-profile_action-buttons">
            {@backgroundUploader()}
          </div>
        </header>
        <Tabs defaultTab="ratings" queryModificator={@resetPage}>
          <Tab key="ratings" id="ratings" title="Рейтинги (#{user.ratingsCount})">
            <Ratings ratings={ratings} pagesCount={ratingPagesCount} page={page}/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии (#{user.commentsCount})">
            <Comments comments={comments} pagesCount={commentPagesCount} page={page}/>
          </Tab>
        </Tabs>
      </div>
    </Layout>

mapStateToProps = ({router, user, userRatings, userComments}) ->
  user: user.item
  userSlug: router.params.userSlug
  isFetched: user.isFetched
  page: parseInt(router.location.query?.page || 1)
  ratings: userRatings.items
  ratingPagesCount: userRatings.pagesCount
  comments: userComments.items
  commentPagesCount: userComments.pagesCount

module.exports = connect(mapStateToProps)(User)
