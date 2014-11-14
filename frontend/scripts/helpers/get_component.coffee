components = require '../components'

module.exports = (path) ->
  path.split('.').reduce (current, part) ->
    current[part]
  , components
