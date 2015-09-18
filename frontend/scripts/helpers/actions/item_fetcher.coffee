fetcher = require './fetcher'

itemFetcher = ({name, url, responseKey}) ->
  fetcher
    name: name
    url: url
    responseKey: responseKey
    getItems: (state) -> state[name].item
    shouldUseCache: ({state}) ->
      state[name].isFetching or state[name].isFetched
    shouldClearState: ({state, args}) ->
      return false unless state[name].item.slug?
      state[name].item.slug != args[0]

module.exports = itemFetcher
