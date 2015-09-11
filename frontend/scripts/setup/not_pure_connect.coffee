_ = require 'lodash'
ReactRedux = require 'react-redux'

ReactRedux.connect = _.wrap ReactRedux.connect, (connect, mapStateToProps, mapDispatchToProps, mergeProps, options = {}) ->
  options?.pure = false
  connect mapStateToProps, mapDispatchToProps, mergeProps, options

module.exports = ->
