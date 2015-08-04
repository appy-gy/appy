prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = []

  errors.push 'Добавьте заголовок' unless rating.title
  errors.push 'Добавьте описание' unless rating.description
  errors.push 'Добавьте хотя бы два пункта' if ratingItems.length < 2

  errors

module.exports = prepublishValidation
