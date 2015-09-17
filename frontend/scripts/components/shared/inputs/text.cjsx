_ = require 'lodash'
React = require 'react'
Textarea = if process.env.TOP_ENV == 'test' then 'textarea' else require('react-textarea-autosize')

TextInput = React.createClass
  displayName: 'TextInput'

  render: ->
    props = _.omit @props, 'children'

    <Textarea {...props}/>

module.exports = TextInput
