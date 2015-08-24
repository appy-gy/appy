_ = require 'lodash'
React = require 'react/addons'
ConfirmationPopup = require '../../components/shared/popups/confirmation'
Popup = require '../../models/popup'

confirmPopup = (app, props) ->
  removePopup = -> app.popupsActions.remove popup

  ['onConfirm', 'onCancel'].each (prop) ->
    props[prop] = _.wrap props[prop], (fn) ->
      removePopup()
      fn?()

  popup = new Popup
    type: 'confirmation'
    content: <ConfirmationPopup {...props}/>

  app.popupsActions.append popup

module.exports = confirmPopup
