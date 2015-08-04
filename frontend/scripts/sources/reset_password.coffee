Marty = require 'marty'

class ResetPasswordApi extends Marty.HttpStateSource
  baseUrl: '/api/private/reset_passwords'

  reset: (email) ->
    @post url: '', body: { email }

module.exports = ResetPasswordApi
