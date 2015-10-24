_ = require 'lodash'
strip = require 'strip'

prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = []

  errors.push 'Добавьте картинку для рейтинга' unless rating.image
  errors.push 'Добавьте рубрику' unless rating.section
  errors.push 'Добавьте заголовок' if _.isEmpty rating.title
  errors.push 'Добавьте описание' if _.isEmpty strip(rating.description)
  errors.push 'Добавьте хотя бы два пункта' if ratingItems.length < 2

  errors

module.exports = prepublishValidation
