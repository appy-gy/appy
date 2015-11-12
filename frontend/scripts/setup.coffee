# replacePromise = require './setup/replace_promise'
polyfillSetImmediate = require './setup/polyfill_set_immediate'
polyfillSet = require './setup/polyfill_set'
arrayEach = require './setup/array_each'
momentLocale = require './setup/moment_locale'
initSmoothScroll = require './setup/init_smooth_scroll'
notPureConnect = require './setup/not_pure_connect'
httpPrependBaseUrl = require './setup/http_prepend_base_url'
httpCamelcaseData = require './setup/http_camelcase_data'
setPixelRatio = require './setup/set_pixel_ratio'

setup = ->
  # replacePromise()
  polyfillSetImmediate()
  polyfillSet()
  arrayEach()
  momentLocale()
  initSmoothScroll()
  notPureConnect()
  httpPrependBaseUrl()
  httpCamelcaseData()
  setPixelRatio()

module.exports = setup
