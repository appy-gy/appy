_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
ParsePage = require '../mixins/parse_page'
SyncSlug = require '../mixins/sync_slug'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
Ratings = require './ratings'
Comments = require './comments'
Layout = require '../layout/layout'
Tabs = require '../shared/tabs/tabs'
Tab = require '../shared/tabs/tab'
User = require '../../models/user'

{PropTypes} = React

UserPage = React.createClass
  displayName: 'User'

  mixins: [ParsePage, SyncSlug('user')]

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    user: PropTypes.object.isRequired
    userSlug: PropTypes.string.isRequired
    page: PropTypes.number.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {user, userSlug} = @props

    { user, userSlug, page: @currentPage(), block: 'user-profile' }

  currentPage: ->
    {router} = @context

    @parsePage router.getCurrentQuery().page

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
            <Ratings page={@currentPage()}/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии (#{user.commentsCount})">
            <Comments page={@currentPage()}/>
          </Tab>
        </Tabs>
      </div>
    </Layout>

module.exports = Marty.createContainer UserPage,
  listenTo: 'usersStore'

  mixins: [ClearStores]

  fetch: ->
    {userSlug} = @props

    user: @app.usersStore.get(userSlug)

  pending: ->
    @done user: new User
