_ = require 'lodash'

AssocArray =
  create: (array = [], model) ->
    toModel = (obj) ->
      if obj.constructor == model then obj else new model obj

    _.tap array.map(toModel), (array) ->
      oldPush = array.push.bind(array)
      Object.defineProperty array, 'push',
        enumerable: false
        configurable: false

        value: (objs...) ->
          oldPush objs.map(toModel)...

      oldUnshift = array.unshift.bind(array)
      Object.defineProperty array, 'unshift',
        enumerable: false
        configurable: false

        value: (objs...) ->
          oldUnshift objs.map(toModel)...

module.exports = AssocArray
