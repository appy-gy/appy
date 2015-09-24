_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
isClient = require '../../../helpers/is_client'
MediumEditor = require 'medium-editor' if isClient()

{PropTypes} = React

Editor = React.createClass
  displayName: 'Editor'

  propTypes:
    value: PropTypes.string
    onChange: PropTypes.func
    options: PropTypes.object

  defaultOptions:
    targetBlank: true
    toolbar:
      buttons: [
        { name: 'bold', aria: 'Жирный' }
        { name: 'italic', aria: 'Наклонный' }
        { name: 'underline', aria: 'Подчеркнутый' }
        { name: 'anchor', aria: 'Ссылка' }
      ]
    autoLink: true
    imageDragging: false

  getDefaultProps: ->
    value: ''
    onChange: ->
    options: {}

  getInitialState: ->
    value: @props.value

  componentDidMount: ->
    {onChange, options} = @props

    return unless isClient()

    el = ReactDOM.findDOMNode @
    @editor = new MediumEditor el, _.defaultsDeep(options, @defaultOptions)
    @editor.subscribe 'editableInput', (event) =>
      @updated = true
      onChange el.innerHTML

  componentWillUnmount: ->
    @editor.destroy()

  componentWillReceiveProps: (nextProps) ->
    {value} = @state
    {value: nextValue} = nextProps

    @setState value: nextValue if value != nextValue and not @updated
    @updated = false

  render: ->
    {value} = @state

    props = _.omit @props, 'value', 'onChange', 'options'

    <div dangerouslySetInnerHTML={__html: value} {...props}></div>

module.exports = Editor
