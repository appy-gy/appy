# Only to watch for router params and query changes,
# we don't want second angular here
# Should be replaced with custom react-router history provider
# when 1.0 of it will be released
# You should pass object with two keys:
# exp - function that returns current value
# onChange - function to be called on exp result change

Watch =
  watch: (watcher) ->
    @watchers ||= []
    @watchers.push watcher

  componentWillUpdate: ->
    @watchers?.each (watcher) ->
      watcher.value = watcher.exp()

  componentDidUpdate: ->
    @watchers?.each ({exp, value, onChange}) ->
      onChange() unless value == exp()

module.exports = Watch
