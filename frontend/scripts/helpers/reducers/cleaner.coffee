constantize = require '../constantize'

cleaner = (name, defaultState) ->
  "CLEAR_#{constantize name}": ->
    defaultState()

module.exports = cleaner
