ReduxActions = require 'redux-actions'

{createAction} = ReduxActions

appendPopup = createAction 'APPEND_POPUP'
removePopup = createAction 'REMOVE_POPUP'
removePopupsWithType = createAction 'REMOVE_POPUPS_WITH_TYPE'

module.exports = { appendPopup, removePopup, removePopupsWithType }
