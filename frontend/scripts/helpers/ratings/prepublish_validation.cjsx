_ = require 'lodash'
React = require 'react'
strip = require 'strip'

prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = [
    {
      text: <span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">заголовок</span></span>
      condition: _.isEmpty(rating.title)
    }
    {
      text: <span>Что бы опубликовать рейтинг выберите <span className="rating-statusbar_link">рубрику</span></span>
      condition: !rating.section
    }
    {
      text: <span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">описание</span></span>
      condition: _.isEmpty(strip(rating.description))
    }
    {
      text: <span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">картинку</span> для рейтинга</span>
      condition: !rating.image
    }
    {
      text: <span>Что бы опубликовать рейтинг добавьте хотя бы <span className="rating-statusbar_link">два пункта</span></span>
      condition: ratingItems.length < 2
    }
  ]

  { errors: _.map(_.filter(errors, 'condition', true), 'text'), errorsTotal: errors.length }

module.exports = prepublishValidation
