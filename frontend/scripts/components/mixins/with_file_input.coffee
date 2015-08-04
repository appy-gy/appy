_ = require 'lodash'

WithFileInput =
  getInitialState: ->
    isPreloadingImage: false

  componentWillMount: ->
    @fileInputFns = {}
    @prevImage = null

  componentWillUpdate: (nextProps, nextState, nextContext) ->
    image = @imageUrlFor { @props, @state, @context }
    nextImage = @imageUrlFor props: nextProps, state: nextState, context: nextContext

    return if image == nextImage or not _.startsWith(image, 'blob:')

    @prevImage = image
    @preloadImage nextImage

  imageUrl: ->
    {isPreloadingImage} = @state

    if isPreloadingImage then @prevImage else @imageUrlFor({ @props, @state, @context })

  preloadImage: (url) ->
    @setState isPreloadingImage: true

    image = new Image
    image.onload = => @setState isPreloadingImage: false
    image.src = url

  openSelect: ->
    @fileInputFns.open()

  fileInputProps: ->
    ref: 'input', utilFns: @fileInputFns

module.exports = WithFileInput
