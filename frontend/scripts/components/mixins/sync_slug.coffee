_ = require 'lodash'

SyncSlug = (name) ->
  componentWillUpdate: (nextProps) ->
    slug = nextProps["#{name}Slug"]
    {router} = @context
    object = if _.has nextProps, name then nextProps[name] else @[name](slug)

    return if not object? or router.getCurrentParams()["#{name}Slug"] == object.slug

    setImmediate -> router.replaceWith name, "#{name}Slug": object.slug

module.exports = SyncSlug
