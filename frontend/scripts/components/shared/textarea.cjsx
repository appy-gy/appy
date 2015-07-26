_ = require 'lodash'
React = require 'react/addons'
Textarea = require 'react-textarea-autosize'

module.exports = React.createClass
  displayName: 'Textarea'

  render: ->
    props = _.omit @props, 'children'

    <Textarea {...props}/>
