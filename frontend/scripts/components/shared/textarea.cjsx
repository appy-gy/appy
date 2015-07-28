_ = require 'lodash'
React = require 'react/addons'
Textarea = if process.env.TOP_ENV == 'test' then 'textarea' else require('react-textarea-autosize')

module.exports = React.createClass
  displayName: 'Textarea'

  render: ->
    props = _.omit @props, 'children'

    <Textarea {...props}/>
