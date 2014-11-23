module.exports = ->
  Array::each = (fn) ->
    @forEach (value, index, array) ->
      fn value, index, array
      true
