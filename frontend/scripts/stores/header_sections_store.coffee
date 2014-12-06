BaseStore = require './base_store'
Section = require '../models/section'

class HeaderSectionsStore extends BaseStore
  constructor: ->
    super()
    @name = 'header_sections'
    @clear()

  getSections: ->
    @sections

  preload: (sections) ->
    @sections = sections.map (section) -> new Section section

  clear: ->
    @sections = []

module.exports = new HeaderSectionsStore
