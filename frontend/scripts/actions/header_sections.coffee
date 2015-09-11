ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestHeaderSections = createAction 'REQUEST_HEADER_SECTIONS'
receiveHeaderSections = createAction 'RECEIVE_HEADER_SECTIONS'

fetchHeaderSections = (page) ->
  (dispatch, getState) ->
    dispatch requestHeaderSections()

    axios.get('header_sections').then ({data}) ->
      dispatch receiveHeaderSections(data.sections)

module.exports = { fetchHeaderSections }
