_ = require 'lodash'
React = require 'react'
strip = require 'strip'

prepublishValidation = (rating, ratingItems = rating.items) ->
  errors = []

  errors.push(<span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">заголовок</span></span>) if _.isEmpty rating.title
  errors.push(<span>Что бы опубликовать рейтинг выберите <span className="rating-statusbar_link">рубрику</span></span>) unless rating.section
  errors.push(<span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">описание</span></span>) if _.isEmpty strip(rating.description)
  errors.push(<span>Что бы опубликовать рейтинг добавьте <span className="rating-statusbar_link">картинку</span> для рейтинга</span>) unless rating.image
  errors.push(<span>Что бы опубликовать рейтинг добавьте хотя бы <span className="rating-statusbar_link">два пункта</span></span>) if ratingItems.length < 2

  errors

module.exports = prepublishValidation
