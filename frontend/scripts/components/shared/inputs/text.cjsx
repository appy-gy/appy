_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
Textarea = if process.env.TOP_ENV == 'test' then 'textarea' else require('react-textarea-autosize')

TextInput = React.createClass
  displayName: 'TextInput'

  mixins: [PureRendexMixin]

  render: ->
    props = _.omit @props, 'children'

    <Textarea {...props}/>

module.exports = TextInput
