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
        { name: 'anchor', aria: 'Ссылка' }
        { name: 'quote', aria: 'Цитирование' }
        { name: 'removeFormat', aria: 'Очистить форматирование'}
      ]
    autoLink: true
    imageDragging: false

  getDefaultProps: ->
    value: ''
    onChange: ->
    options: {}

  componentDidMount: ->
    {options, onChange} = @props

    return unless isClient()

    node = ReactDOM.findDOMNode @
    options = _.defaultsDeep {}, options, @defaultOptions

    @editor = new MediumEditor node, options
    @editor.subscribe 'editableInput', ->
      onChange node.innerHTML

  componentWillUnmount: ->
    @editor.destroy()

  shouldComponentUpdate: ->
    false

  render: ->
    {value} = @props

    props = _.omit @props, 'value', 'options', 'onChange'

    <div contentEditable dangerouslySetInnerHTML={__html: value} {...props}></div>

module.exports = Editor
