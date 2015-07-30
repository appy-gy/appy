_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
canEditUser = require '../../helpers/users/can_edit'
User = require '../../models/user'
ClearStores = require '../mixins/clear_stores'
ParsePage = require '../mixins/parse_page'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
RatingTabs = require './rating_tabs'
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
    page: PropTypes.number.isRequired
    isOwnPage: PropTypes.bool.isRequired
    canEdit: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {user, userSlug} = @props

    { user, userSlug, page: @currentPage(), isOwnPage: @isOwnPage(), canEdit: @canEdit(), block: 'user-profile' }

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
        </header>
        <Tabs defaultTab="ratings" queryModificator={@resetPage}>
          <Tab key="ratings" id="ratings" title="Рейтинги (#{user.ratingsCount})">
            <RatingTabs/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии (#{user.commentsCount})">
            <Comments/>
          </Tab>
        </Tabs>
      </div>
    </Layout>

module.exports = Marty.createContainer UserPage,
  listenTo: ['usersStore', 'currentUserStore']

  mixins: [ClearStores()]

  fetch: ->
    {userSlug} = @props

    user: @app.usersStore.get(userSlug)
    currentUser: @app.currentUserStore.get()
