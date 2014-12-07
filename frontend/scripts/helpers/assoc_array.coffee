AssocArray =
  create: (array = [], model) ->
    toModel = (obj) ->
      if obj.constructor == model then obj else new model obj

    array = array.map toModel

    oldPush = array.push.bind(array)
    array.push = (objs...) ->
      oldPush objs.map(toModel)...

    oldUnshift = array.unshift.bind(array)
    array.unshift = (objs...) ->
      oldUnshift objs.map(toModel)...

window.AssocArray = AssocArray if window?
module.exports = AssocArray
