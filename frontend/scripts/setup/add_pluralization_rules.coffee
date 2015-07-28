pluralize = require 'pluralize'

module.exports = ->
  pluralize.addIrregularRule 'published', 'published'
