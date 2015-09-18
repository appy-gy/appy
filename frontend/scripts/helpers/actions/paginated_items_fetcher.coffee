_ = require 'lodash'
fetcher = require './fetcher'

paginatedItemsFetcher = ({name, url, responseKey, getPage, getSlugFromState, getSlugFromArgs}) ->
  responseKey ||= name
  shouldClearState = ({state, args}) ->
    return false unless getSlugFromState? and getSlugFromArgs?
    return false unless getSlugFromState(state)?
    getSlugFromState(state) != getSlugFromArgs(args)

  fetcher
    name: name
    url: url
    responseKey: responseKey
    getItems: (state) -> state[name].items
    shouldUseCache: ({state, args}) ->
      {fetchingPages, fetchedPages} = state[name]
      _(fetchingPages).concat(fetchedPages).includes(getPage(args))
    shouldClearState: shouldClearState
    requestOpts: ({args}) -> params: { page: getPage args }
    requestPayload: ({args}) -> getPage args
    receivePayload: ({args, data}) ->
      page = getPage args
      data[responseKey].each (item) -> item.page = page
      { "#{name}": data[responseKey], page, pagesCount: data.meta.pagesCount }

module.exports = paginatedItemsFetcher
