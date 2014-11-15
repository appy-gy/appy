module.exports = (obj, path) ->
  path.split('.').reduce (current, part) ->
    current[part]
  , obj
