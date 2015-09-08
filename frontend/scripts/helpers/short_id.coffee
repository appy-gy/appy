shortId = (id) ->
  return unless id?
  id.split('-')[0]

module.exports = shortId
