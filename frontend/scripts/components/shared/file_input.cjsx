_ = require 'lodash'
React = require 'react/addons'
Classes = require '../mixins/classes'

{PropTypes} = React

FileInput = React.createClass
  displayName: 'FileInput'

  mixins: [Classes]

  propTypes:
    onChange: PropTypes.func.isRequired
    children: PropTypes.node

  onChange: (event) ->
    {onChange} = @props

    onChange event.target.files

  render: ->
    {children} = @props

    props = _.omit @props, 'className', 'onChange', 'children'

    <div className={@classes('file-input')} {...props}>
      <input type="file" className="file-input_input" onChange={@onChange}/>
      {children}
    </div>

module.exports = FileInput
