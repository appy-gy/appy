prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = []

  errors.push 'добавьте заголовок рейтинга' unless rating.title
  errors.push 'добавьте описание рейтинга' unless rating.description
  errors.push 'добавьте хотя бы два рейтинга' if ratingItems.length < 2

  errors

module.exports = prepublishValidation
