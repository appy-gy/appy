BaseStorage = require './base_storage'
User = require '../models/user'

class CurrentUserStorage extends BaseStorage
  constructor: ->
    @clear()

  preload: (user) ->
    @user = new User user

  clear: ->
    @user = null

module.exports = new CurrentUserStorage
