loaderActions = require '../../actions/loader'

{changeLoaderVisibility} = loaderActions

Loading =
  componentDidMount: ->
    return unless @shouldShowLoader()
    @showLoader()

  componentDidUpdate: ->
    return if @shouldShowLoader()
    @hideLoader()

  showLoader: ->
    {dispatch} = @props

    dispatch changeLoaderVisibility(true)

  hideLoader: ->
    {dispatch} = @props

    dispatch changeLoaderVisibility(false)

module.exports = Loading
