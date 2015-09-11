ReduxActions = require 'redux-actions'

{createAction} = ReduxActions

setLoaderVisibility = createAction 'SET_LOADER_VISIBILITY'

changeLoaderVisibility = (visible) ->
  (dispatch, getState) ->
    {loader} = getState()
    return if visible == loader.visible
    dispatch setLoaderVisibility(visible)

module.exports = { changeLoaderVisibility }
