fetcher = require './fetcher'

itemsFetcher = ({name, url, responseKey, getSlugFromState, getSlugFromArgs}) ->
  shouldClearState = ({state, args}) ->
    return false unless getSlugFromState? and getSlugFromArgs?
    return false unless getSlugFromState(state)?
    getSlugFromState(state) != getSlugFromArgs(args)

  fetcher
    name: name
    url: url
    responseKey: responseKey
    getItems: (state) -> state[name].items
    shouldUseCache: ({state}) ->
      state[name].isFetching or state[name].isFetched
    shouldClearState: shouldClearState

module.exports = itemsFetcher
