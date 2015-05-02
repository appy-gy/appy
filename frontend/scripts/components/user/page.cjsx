React = require 'react/addons'
Router = require 'react-router'
Marty = require 'marty'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
EditButtons = require './edit_buttons'
Ratings = require './ratings'
Layout = require '../layout/layout'
Tabs = require '../shared/tabs/tabs'
Tab = require '../shared/tabs/tab'
Snapshot = require '../../helpers/snapshot'
UserActionCreators = require '../../action_creators/users'
UsersStore = require '../../stores/users'

{PropTypes} = React
{Link} = Router

User = React.createClass
  displayName: 'User'

  childContextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getInitialState: ->
    edit: false

  getChildContext: ->
    {user} = @props
    {edit} = @state

    { user, edit, block: 'user-profile' }

  startEdit: ->
    {user} = @props

    @snapshot = Snapshot.create user
    @setState edit: true

  saveUser: ->
    {user} = @props

    changes = Snapshot.diff user, @snapshot
    UserActionCreators.update user.id, changes
    @setState edit: false

  cancelEdit: ->
    {user} = @props

    Snapshot.restore user, @snapshot
    @setState edit: false

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
          <EditButtons start={@startEdit} save={@saveUser} cancel={@cancelEdit}/>
        </header>
        <Tabs>
          <Tab key="ratings" id="ratings" title="Рейтинги">
            <Ratings/>
          </Tab>
          <Tab key="comments" id="comments" title="Комментарии">
            <h2 className="user-profile_tab-title">Ваши комментарии<span> (323424)</span></h2>
          </Tab>
        </Tabs>
      </div>
    </Layout>

module.exports = Marty.createContainer User,
  listenTo: UsersStore

  fetch: ->
    {userId} = @props

    user: UsersStore.for(@).get(userId)
