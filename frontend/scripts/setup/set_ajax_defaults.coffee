$ = require 'jquery'

module.exports = ->
  token = document.querySelector('meta[name="csrf-token"]').content
  $.ajaxSetup
    headers:
      'X-CSRF-Token': token
