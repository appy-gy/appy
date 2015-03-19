Base = require './base'

class User extends Base
  isLoggedIn: ->
    @id?

module.exports = User
