Loading =
  componentDidMount: ->
    return unless @shouldShowLoader()
    @showLoader()

  componentDidUpdate: ->
    return if @shouldShowLoader()
    @hideLoader()

  showLoader: ->
    @app.loaderVisibilityStore.set true

  hideLoader: ->
    @app.loaderVisibilityStore.set false

module.exports = Loading
