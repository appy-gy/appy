module.exports = ->
  Object.defineProperty Array::, 'each',
    value: (fn) ->
      @forEach (value, index, array) ->
        fn value, index, array
        true
