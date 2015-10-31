_ = require 'lodash'
ReduxRouter = require 'redux-router'

{replaceState} = ReduxRouter

SyncSlug = (name, url) ->
  componentWillUpdate: (nextProps) ->
    {dispatch} = @props
    {slug} = @props[name]
    {slug: nextSlug} = nextProps[name]

    return if not slug? or not nextSlug? or slug == nextSlug

    newUrl = if _.isString(url) then "#{url}/#{nextSlug}" else url(nextSlug, nextProps)

    dispatch replaceState(null, newUrl)

module.exports = SyncSlug
