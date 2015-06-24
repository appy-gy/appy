isClient = require '../helpers/is_client'

{trace} = console

keepConsoleTrace = ->
  return unless isClient() and process.env.TOP_ENV == 'development'
  console.btrace = trace

module.exports = keepConsoleTrace
