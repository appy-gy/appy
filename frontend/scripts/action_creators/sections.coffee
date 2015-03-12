Marty = require 'marty'
SectionsConstants = require '../constants/sections'

SectionsActionCreators = Marty.createActionCreators
  append: SectionsConstants.APPEND_SECTIONS (sections) ->
    @dispatch sections

module.exports = SectionsActionCreators
