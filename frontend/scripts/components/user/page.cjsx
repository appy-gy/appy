_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
canEditUser = require '../../helpers/users/can_edit'
canSeeRatingDrafts = require '../../helpers/ratings/can_see_drafts'
ParsePage = require '../mixins/parse_page'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
Settings = require './settings'
Ratings = require './ratings'
Comments = require './comments'
Layout = require '../layout/layout'
Tabs = require '../shared/tabs/tabs'
Tab = require '../shared/tabs/tab'

{PropTypes} = React

UserPage = React.createClass
  displayName: 'User'

  mixins: [ParsePage, SyncSlug('user'), Loading]

  propTypes:
    user: PropTypes.object.isRequired
    currentUser: PropTypes.object.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    user: PropTypes.object.isRequired
    userSlug: PropTypes.string.isRequired
    isOwnPage: PropTypes.bool.isRequired
    canEdit: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {user, userSlug} = @props

    { user, userSlug, isOwnPage: @isOwnPage(), canEdit: @canEdit(), block: 'user-profile' }

  componentWillUpdate: (nextProps) ->
    {user, currentUser} = @props

    return if canSeeRatingDrafts(currentUser, user) == canSeeRatingDrafts(nextProps.currentUser, user)

    @app.ratingsStore.clear()
    @app.usersStore.clear()

  isOwnPage: ->
    {user, currentUser} = @props

    currentUser?.id == user.id

  canEdit: ->
    {user, currentUser} = @props

    canEditUser currentUser, user

  currentPage: ->
    {router} = @context

    @parsePage router.getCurrentQuery().page

  isSlugChanged: ({user}) ->
    {router} = @context

    user?.slug? and router.getCurrentParams().userSlug != user.slug

  shouldShowLoader: ->
    {user} =  @props

    not user?.id?

  resetPage: (query) ->
    delete query.page
    query

  settings: ->
    return unless @canEdit()

    <Settings/>

  render: ->
    {user} = @props

    <Layout>
      <div className="user-profile">
        <header className="user-profile_header">
          <Avatar/>
          <div className="user-profile_info">
            <Name/>
            <SocialButtons/>
          </div>
          {@settings()}
        </header>
        <Tabs defaultTab="ratings" queryModificator={@resetPage}>
          <Tab key="ratings" id="ratings" title="Рейтинги (#{user.ratingsCount})">
            <Ratings page={@currentPage()}/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии (#{user.commentsCount})">
            <Comments page={@currentPage()}/>
          </Tab>
        </Tabs>
      </div>
    </Layout>

module.exports = Marty.createContainer UserPage,
  listenTo: ['usersStore', 'currentUserStore']

  fetch: ->
    {userSlug} = @props

    user: @app.usersStore.get(userSlug)
    currentUser: @app.currentUserStore.get()
