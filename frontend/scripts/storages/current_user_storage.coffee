BaseStorage = require './base_storage'
CurrentUser = require '../models/current_user'

class CurrentUserStorage extends BaseStorage
  constructor: ->
    @clear()

  preload: (user) ->
    @user = new User user

  clear: ->
    @user = null

module.exports = new CurrentUserStorage
