Marty = require 'marty'
HeaderSectionsConstants = require '../constants/header_sections'

HeaderSectionsActionCreators = Marty.createActionCreators
  set: HeaderSectionsConstants.SET_HEADER_SECTIONS (sections) ->
    @dispatch sections

module.exports = HeaderSectionsActionCreators
