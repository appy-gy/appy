receiver = require './receiver'

itemReceiver = (name) ->
  receiver { name, key: 'item', defaultValue: {} }

module.exports = itemReceiver
