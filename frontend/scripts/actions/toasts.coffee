ReduxActions = require 'redux-actions'

{createAction} = ReduxActions

appendToast = createAction 'APPEND_TOAST'
removeToast = createAction 'REMOVE_TOAST'

module.exports = { appendToast, removeToast }
