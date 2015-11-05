_ = require 'lodash'
strip = require 'strip'

prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = []

  errors.push 'добавьте <span class="rating-statusbar_link">заголовок</span>' if _.isEmpty rating.title
  errors.push 'добавьте <span class="rating-statusbar_link">рубрику</span>' unless rating.section
  errors.push 'добавьте <span class="rating-statusbar_link">описание</span>' if _.isEmpty strip(rating.description)
  errors.push 'добавьте <span class="rating-statusbar_link">картинку</span> для рейтинга' unless rating.image
  errors.push 'добавьте хотя бы <span class="rating-statusbar_link">два пункта</span>' if ratingItems.length < 2

  errors

module.exports = prepublishValidation
