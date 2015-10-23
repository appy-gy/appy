OnRouteChanged =
  handleEnter: (nextState) ->
    {query} = nextState.location

    scroll 0, 0

module.exports = OnRouteChanged
