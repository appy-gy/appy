isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  window.localStorage ||=
    _data: {}
    setItem: (id, val) -> @_data[id] = String(val)
    getItem: (id) -> if @_data.hasOwnProperty(id) then String(@_data[id]) else undefined
    removeItem: (id) -> delete @_data[id]
    clear: -> @_data = {}
