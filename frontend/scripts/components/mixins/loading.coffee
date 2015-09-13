loaderActions = require '../../actions/loader'

{changeLoaderVisibility} = loaderActions

Loading =
  componentDidMount: ->
    return unless @isLoading()
    @showLoader()

  componentDidUpdate: ->
    return if @isLoading()
    @hideLoader()

  showLoader: ->
    {dispatch} = @props

    dispatch changeLoaderVisibility(true)

  hideLoader: ->
    {dispatch} = @props

    dispatch changeLoaderVisibility(false)

module.exports = Loading
