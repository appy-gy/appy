_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
canEditUser = require '../../helpers/users/can_edit'
canSeeRatingDrafts = require '../../helpers/ratings/can_see_drafts'
ParsePage = require '../mixins/parse_page'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Watch = require '../mixins/watch'
Avatar = require './avatar'
Name = require './name'
SocialButtons = require './social_buttons'
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

User = React.createClass
  displayName: 'User'

  mixins: [Loading, ParsePage, SyncSlug('user'), Watch]

  propTypes:
    dispatch: PropTypes.func.isRequired
    userSlug: PropTypes.string.isRequired
    user: PropTypes.object.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
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

    @watch
      exp: (props, state, {currentUser}) -> currentUser.id
      onChange: @fetchUser

  isLoading: ->
    @props.isFetching

  isSlugChanged: ({user}) ->
    user?.slug? and @context.router.getCurrentParams().userSlug != user.slug

  currentPage: ->
    @parsePage @context.router.getCurrentQuery().page

  isOwnPage: ->
    @context.currentUser.id == @props.user.id

  canEdit: ->
    canEditUser @context.currentUser, @props.user

  fetchUser: ->
    @props.dispatch fetchUser(@props.userSlug)

  resetPage: (query) ->
    _.omit query, 'page'

  settings: ->
    <Settings/> if @canEdit()

  render: ->
    {user} = @props

    return <Nothing/> if @isLoading()

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

mapStateToProps = ({user}) ->
  user: user.item, isFetching: user.isFetching

module.exports = connect(mapStateToProps)(User)
