receiver = require './receiver'

itemsReceiver = (name) ->
  receiver { name, key: 'items', defaultValue: [] }

module.exports = itemsReceiver
