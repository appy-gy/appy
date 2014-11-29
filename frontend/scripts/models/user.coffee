Base = require './base'

class User extends Base
  loggedIn: ->
    @id?

module.exports = User
