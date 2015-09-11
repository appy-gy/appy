# Only to watch for router params and query changes,
# we don't want second angular here
# Should be replaced with custom react-router history provider
# when 1.0 of it will be released
# You should pass object with two keys:
# exp - function that returns current value
# onChange - function to be called on exp result change

Watch =
  componentWillMount: ->
    @watchers = []

  watch: (watcher) ->
    @watchers.push watcher

  componentWillUpdate: (prevProps, prevState, prevContext) ->
    @watchers.each (watcher) ->
      watcher.value = watcher.exp prevProps, prevState, prevContext

  componentDidUpdate: (nextProps, nextState, nextContext) ->
    @watchers.each ({exp, value, onChange}) ->
      onChange() unless value == exp(nextProps, nextState, nextContext)

module.exports = Watch
