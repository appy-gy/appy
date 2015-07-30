_ = require 'lodash'

isSlugChanged = ({name, object, router}) ->
  object? and router.getCurrentParams()["#{name}Slug"] != object.slug

SyncSlug = (name) ->
  componentWillUpdate: (nextProps) ->
    slug = nextProps["#{name}Slug"]
    {router} = @context
    object = if _.has nextProps, name then nextProps[name] else @[name](slug)
    checker = if @isSlugChanged? then _.partial(@isSlugChanged, nextProps) else _.partial(isSlugChanged, { name, object, router })

    return unless checker()

    setImmediate -> router.replaceWith name, "#{name}Slug": object.slug

module.exports = SyncSlug
