Base = require './base'

class User extends Base
  @imageFields 'avatar'

  isLoggedIn: ->
    @id?

module.exports = User
