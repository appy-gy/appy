moment = require 'moment'
ru = require 'moment/locale/ru'

module.exports = ->
  moment.locale 'ru', ru
