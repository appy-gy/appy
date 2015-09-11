loaderActions = require '../../actions/loader'

{setLoaderVisibility} = loaderActions

Loading =
  componentDidMount: ->
    return unless @shouldShowLoader()
    @showLoader()

  componentDidUpdate: ->
    return if @shouldShowLoader()
    @hideLoader()

  showLoader: ->
    {dispatch} = @props

    dispatch setLoaderVisibility(true)

  hideLoader: ->
    {dispatch} = @props

    dispatch setLoaderVisibility(false)

module.exports = Loading
