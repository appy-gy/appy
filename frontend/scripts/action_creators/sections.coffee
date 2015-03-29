Marty = require 'marty'
autoDispatch = require 'marty/autoDispatch'
SectionConstants = require '../constants/sections'

class SectionActionCreators extends Marty.ActionCreators
  append: autoDispatch SectionConstants.APPEND_SECTIONS

module.exports = Marty.register SectionActionCreators
