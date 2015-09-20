fetcher = require './fetcher'

itemFetcher = ({name, url, responseKey}) ->
  fetcher
    name: name
    url: url
    responseKey: responseKey
    getItems: (state) -> state[name].item
    shouldUseCache: ({state}) ->
      state[name].isFetching or state[name].isFetched

module.exports = itemFetcher
