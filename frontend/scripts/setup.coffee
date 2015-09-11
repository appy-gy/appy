polyfillSetImmediate = require './setup/polyfill_set_immediate'
polyfillSet = require './setup/polyfill_set'
arrayEach = require './setup/array_each'
momentLocale = require './setup/moment_locale'
initSmoothScroll = require './setup/init_smooth_scroll'
axiosPrependBaseUrl = require './setup/axios_prepend_base_url'
axiosSetResponseOk = require './setup/axios_set_response_ok'
axiosCamelcaseData = require './setup/axios_camelcase_data'

setup = ->
  polyfillSetImmediate()
  polyfillSet()
  arrayEach()
  momentLocale()
  initSmoothScroll()
  axiosPrependBaseUrl()
  axiosSetResponseOk()
  axiosCamelcaseData()

module.exports = setup
