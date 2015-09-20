fetcher = require './fetcher'

itemsFetcher = ({name, url, responseKey}) ->
  fetcher
    name: name
    url: url
    responseKey: responseKey
    getItems: (state) -> state[name].items
    shouldUseCache: ({state}) ->
      state[name].isFetching or state[name].isFetched

module.exports = itemsFetcher
