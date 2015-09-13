ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestSections = createAction 'REQUEST_SECTIONS'
receiveSections = createAction 'RECEIVE_SECTIONS'

fetchSections = ->
  (dispatch, getState) ->
    dispatch requestSections()

    axios.get('sections').then ({data}) ->
      dispatch receiveSections(data.sections)

module.exports = { fetchSections }
