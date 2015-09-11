ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestSection = createAction 'REQUEST_SECTION'
receiveSection = createAction 'RECEIVE_SECTION'

fetchSection = (id) ->
  (dispatch, getState) ->
    dispatch requestSection()

    axios.get("sections/#{id}").then ({data}) ->
      dispatch receiveSection(data.section)

module.exports = { fetchSection }
