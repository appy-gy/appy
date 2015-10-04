_ = require 'lodash'
React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
isClient = require '../../../helpers/is_client'
MediumEditor = if isClient() then require('react-medium-editor') else 'div'

{PropTypes} = React

Editor = React.createClass
  displayName: 'Editor'

  mixins: [PureRenderMixin]

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

  render: ->
    {value, options} = @props

    @options ||= _.defaultsDeep options, @defaultOptions
    props = _.omit @props, 'value', 'options'

    <MediumEditor text={value} options={@options} {...props}/>

module.exports = Editor
