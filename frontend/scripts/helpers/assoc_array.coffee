_ = require 'lodash'

AssocArray =
  create: (array = [], model) ->
    toModel = (obj) ->
      if obj.constructor == model then obj else new model obj

    _.tap array.map(toModel), (array) ->
      oldPush = array.push.bind(array)
      array.push = (objs...) ->
        oldPush objs.map(toModel)...

      oldUnshift = array.unshift.bind(array)
      array.unshift = (objs...) ->
        oldUnshift objs.map(toModel)...

module.exports = AssocArray
