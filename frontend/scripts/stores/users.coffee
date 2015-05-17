_ = require 'lodash'
Marty = require 'marty'
React = require 'react/addons'
toArray = require '../helpers/to_array'
findInStore = require '../helpers/find_in_store'
UserConstants = require '../constants/users'
UserQueries = require '../queries/users'
User = require '../models/user'

{update} = React.addons

class UsersStore extends Marty.Store
  @id: 'UsersStore'

  constructor: ->
    super
    @handlers =
      append: UserConstants.APPEND_USERS
      change: UserConstants.CHANGE_USER
      replace: UserConstants.REPLACE_USER

  getInitialState: ->
    []

  rehydrate: (state) ->
    users = state.map (user) -> new User user
    @append users

  get: (idOrSlug) ->
    @fetch
      id: "get-#{idOrSlug}"
      locally: ->
        return unless @hasAlreadyFetched "get-#{idOrSlug}"
        findInStore @, idOrSlug
      remotely: ->
        UserQueries.for(@).get(idOrSlug)

  append: (users) ->
    @state = update @state, $push: toArray(users)

  change: (id, changes) ->
    user = _.find @state, (user) -> user.id == id
    return unless user?
    user.update changes
    @hasChanged()

  replace: (user) ->
    index = _.findIndex @state, (u) -> u.id == user.id
    return if index < 0
    @state = update @state, $splice: [[index, 1, user]]

module.exports = Marty.register UsersStore
