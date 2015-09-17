_ = require 'lodash'
React = require 'react'
popupActions = require '../../actions/popups'
buildPopup = require './build'
ConfirmationPopup = require '../../components/shared/popups/confirmation'

{appendPopup, removePopup} = popupActions

confirmPopup = (dispatch, props) ->
  ['onConfirm', 'onCancel'].each (prop) ->
    props[prop] = _.wrap props[prop], (fn) ->
      dispatch removePopup(popup)
      fn?()

  popup = buildPopup
    type: 'confirmation'
    content: -> <ConfirmationPopup {...props}/>

  dispatch appendPopup(popup)

module.exports = confirmPopup
