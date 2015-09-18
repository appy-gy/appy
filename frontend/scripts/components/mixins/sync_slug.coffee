ReduxReactRouter = require 'redux-react-router'

{replaceState} = ReduxReactRouter

SyncSlug = (name, url) ->
  componentWillUpdate: (nextProps) ->
    {dispatch} = @props

    {slug} = @props[name]
    {slug: nextSlug} = nextProps[name]
    return if not slug? or not nextSlug? or slug == nextSlug

    dispatch replaceState(null, "#{url}/#{nextSlug}")

module.exports = SyncSlug
