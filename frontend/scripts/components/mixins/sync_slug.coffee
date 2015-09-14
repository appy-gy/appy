# To use this mixin in your component you should also
# include Watch mixin in it, has router in context and
# has isLoading method defined

SyncSlug = (name) ->
  componentWillMount: ->
    @maybeSetupSlugWatcher()

  componentWillUpdate: ->
    @maybeSetupSlugWatcher()

  maybeSetupSlugWatcher: ->
    return if @isLoading() or @slugWatchSetup

    @slugWatchSetup = true
    currentSlug = => @props[name].slug

    @watch
      exp: currentSlug
      onChange: =>
        @context.router.replaceWith name, "#{name}Slug": currentSlug()

module.exports = SyncSlug
