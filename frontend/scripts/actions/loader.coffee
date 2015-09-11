ReduxActions = require 'redux-actions'

{createAction} = ReduxActions

setLoaderVisibility = createAction 'SET_LOADER_VISIBILITY'

module.exports = { setLoaderVisibility }
