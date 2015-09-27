itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchFooterPages} = itemsFetcher
  name: 'footerPages'
  url: -> 'pages/footer'
  responseKey: 'pages'

module.exports = { fetchFooterPages }
