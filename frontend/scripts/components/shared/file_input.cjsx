_ = require 'lodash'
React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

FileInput = React.createClass
  displayName: 'FileInput'

  mixins: [PureRenderMixin]

  propTypes:
    onChange: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  onChange: (event) ->
    {onChange} = @props

    onChange event.target.files

  render: ->
    {children} = @props

    props = _.omit @props, 'onChange', 'children'

    <div {...props}>
      <input type="file" className="file-input" onChange={@onChange}/>
      {children}
    </div>

module.exports = FileInput
