_ = require 'lodash'
React = require 'react/addons'
buildPopup = require './build'
ConfirmationPopup = require '../../components/shared/popups/confirmation'

confirmPopup = (app, props) ->
  removePopup = -> app.popupsActions.remove popup

  ['onConfirm', 'onCancel'].each (prop) ->
    props[prop] = _.wrap props[prop], (fn) ->
      removePopup()
      fn?()

  popup = buildPopup
    type: 'confirmation'
    content: <ConfirmationPopup {...props}/>

  app.popupsActions.append popup

module.exports = confirmPopup
