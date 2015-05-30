React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
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

  childContextTypes:
    user: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {user} = @props

    { user, block: 'user-profile' }

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
        <Tabs>
          <Tab key="ratings" id="ratings" title="Рейтинги (#{user.ratingsCount})">
            <Ratings/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии (#{user.commentsCount})">
            <Comments/>
          </Tab>
        </Tabs>
      </div>
    </Layout>

module.exports = Marty.createContainer UserPage,
  listenTo: 'usersStore'

  mixins: [ClearStores]

  childContextTypes:
    userSlug: PropTypes.string.isRequired

  getChildContext: ->
    {userSlug} = @props

    { userSlug }

  fetch: ->
    {userSlug} = @props

    user: @app.usersStore.get(userSlug)

  pending: ->
    @done user: new User
