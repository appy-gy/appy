_ = require 'lodash'
React = require 'react/addons'
constantize = require '../constantize'

{update} = React.addons

paginatedItemsReceiver = ({name}) ->
  defaultState = (state = {}) ->
    _.merge state,
      items: []
      fetchingPages: []
      fetchedPages: []
      pagesCount: 0

  handlers =
    "REQUEST_#{constantize name}": (state, {payload: page}) ->
      update state, fetchingPages: { $push: [page] }

    "RECEIVE_#{constantize name}": (state, {payload}) ->
      items = payload[name]
      {page, pagesCount} = payload
      index = _.findIndex state.fetchingPages, page

      update state,
        items: { $push: items }
        fetchingPages: { $splice: [[index, 1]] }
        fetchedPages: { $push: [page] }
        pagesCount: { $set: pagesCount }

  { defaultState, handlers }

module.exports = paginatedItemsReceiver
