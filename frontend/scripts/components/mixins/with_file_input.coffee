WithFileInput =
  componentWillMount: ->
    @fileInputFns = {}

  openSelect: ->
    @fileInputFns.open()

  fileInputProps: ->
    ref: 'input', utilFns: @fileInputFns

module.exports = WithFileInput
