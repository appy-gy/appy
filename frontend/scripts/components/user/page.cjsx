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
Avatar = require './avatar'
Name = require './name'
BackgroundUploader = require './background_uploader'
Settings = require './settings'
Ratings = require './ratings'
Comments = require './comments'
Layout = require '../layout/layout'
TabButton = require '../shared/tabs/button'
TabContent = require '../shared/tabs/content'

{PropTypes} = React
{connect} = ReactRedux
{fetchUser} = userActions
{fetchUserRatings} = userRatingActions
{fetchUserComments} = userCommentActions

User = React.createClass
  displayName: 'User'

  mixins: [SyncSlug('user', '/users')]

  propTypes:
    dispatch: PropTypes.func.isRequired
    user: PropTypes.object.isRequired
    userSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired
    isFailed: PropTypes.bool.isRequired
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

  tabs: [
    {
      id: 'ratings',
      isDefault: true
      button: ({user}) -> "Рейтинги #{user.ratingsCount}"
      content: ({ratings, ratingPagesCount, user, page}) ->
        <Ratings ratings={ratings} count={user.ratingsCount} pagesCount={ratingPagesCount} page={page}/>
    }
    {
      id: 'comments'
      isDefault: false
      button: ({user}) -> "Комментарии #{user.commentsCount}"
      content: ({comments, commentPagesCount, user, page}) ->
        <Comments comments={comments} count={user.commentsCount} pagesCount={commentPagesCount} page={page}/>
    }
  ]

  getChildContext: ->
    {user, userSlug} = @props

    { user, userSlug, isOwnPage: @isOwnPage(), canEdit: @canEdit(), block: 'user-profile' }

  componentWillMount: ->
    @fetchUser()
    @fetchRatings()
    @fetchComments()

  componentDidUpdate: ->
    @fetchUser()
    @fetchRatings()
    @fetchComments()

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

  tabButtons: ->
    @tabs.map ({id, isDefault, button}) =>
      <TabButton key={id} id={id} queryKey="tab" isDefault={isDefault} queryModificator={@resetPage}>
        {button @props}
      </TabButton>

  tabsContent: ->
    @tabs.map ({id, isDefault, content}) =>
      <TabContent key={id} id={id} queryKey="tab" isDefault={isDefault}>
        {content @props}
      </TabContent>

  render: ->
    {user, page, ratings, ratingPagesCount, comments, commentPagesCount, isFetched, isFailed} = @props

    headerStyles = backgroundImage: "url(#{imageUrl user.background, 'normal'})"

    <Layout isLoading={not isFetched} isFound={not isFailed}>
      <Helmet title={user.name}/>
      <div className="user-profile">
        <header className="user-profile_header">
          <div className="user-profile_header-bg" style={headerStyles}>
          </div>
          <div className="user-profile_header-content">
            <Avatar/>
            <div className="user-profile_info">
              <div className="user-profile_name-wrap">
                <Name/>
                {@settings()}
              </div>
              <div className="user-profile_tab-buttons">
                {@tabButtons()}
              </div>
            </div>
            <div className="user-profile_action-buttons">
              {@backgroundUploader()}
            </div>
          </div>
        </header>
        {@tabsContent()}
      </div>
    </Layout>

mapStateToProps = ({router, user, userRatings, userComments}) ->
  user: user.item
  userSlug: router.params.userSlug
  isFailed: user.isFailed
  isFetched: user.isFetched
  page: parseInt(router.location.query?.page || 1)
  ratings: userRatings.items
  ratingPagesCount: userRatings.pagesCount
  comments: userComments.items
  commentPagesCount: userComments.pagesCount

module.exports = connect(mapStateToProps)(User)
