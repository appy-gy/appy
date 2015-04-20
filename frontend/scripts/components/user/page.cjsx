React = require 'react/addons'
Router = require 'react-router'
Marty = require 'marty'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
EditButtons = require './edit_buttons'
Ratings = require './ratings'
UserActionCreators = require '../../action_creators/users'
UsersStore = require '../../stores/users'
Snapshot = require '../../helpers/snapshot'

{PropTypes} = React
{Link} = Router

User = React.createClass
  displayName: 'User'

  childContextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  getInitialState: ->
    edit: false

  getChildContext: ->
    {user} = @props
    {edit} = @state

    { user, edit }

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

    <div className="user-profile">
      <header className="user-profile_header">
        <Avatar/>
        <div className="user-profile_info">
          <Name/>
          <SocialButtons/>
        </div>
        <EditButtons start={@startEdit} save={@saveUser} cancel={@cancelEdit}/>
      </header>
      <section className="user-profile_tabs">
        <input id="tab1" name="radio" className="user-profile_tabs-radio" type="radio" defaultChecked/>
        <input id="tab2" name="radio" className="user-profile_tabs-radio" type="radio"/>
        <div className="user-profile_tabs-nav">
          <label id="label1" for="tab1" className="user-profile_tabs-nav-item">
            Рейтинги
          </label>
          <label id="label2" for="tab2" className="user-profile_tabs-nav-item">
            Комментарии
          </label>
        </div>
        <div className="user-profile_tab-content-wrapper">
          <div id="content1" className="user-profile_tab-content">
            <Ratings/>
          </div>
          <div id="content2" className="user-profile_tab-content">
            <h2 className="user-profile_tab-title">Ваши комментарии<span> (323424)</span></h2>
          </div>
        </div>
      </section>
    </div>

module.exports = Marty.createContainer User,
  listenTo: UsersStore

  fetch: ->
    {userId} = @props

    user: UsersStore.for(@).get(userId)
