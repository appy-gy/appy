_ = require 'lodash'
React = require 'react'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
Classes = require '../../mixins/classes'

{PropTypes} = React
{DropTarget} = ReactDnd
{NativeTypes} = HTML5Backend

fileTarget =
  drop: (props, monitor, component) ->
    {files} = monitor.getItem()
    {onSelect} = component

    onSelect files
    return

collectTarget = (connect) ->
  connectDropTarget: connect.dropTarget()

FileInput = React.createClass
  displayName: 'FileInput'

  mixins: [Classes]

  propTypes:
    connectDropTarget: PropTypes.func.isRequired
    onSelect: PropTypes.func.isRequired
    utilFns: PropTypes.object
    children: PropTypes.node

  getDefaultProps: ->
    utilFns: {}

  componentWillMount: ->
    {utilFns} = @props

    _.merge utilFns, _.pick(@, 'open')

  open: ->
    {input} = @refs

    input.value = null
    input.click()

  onChange: (event) ->
    event.preventDefault()

    @onSelect event.target.files

  onSelect: (files) ->
    {onSelect} = @props

    files = _.toArray files
    files.each (file) -> file.preview = URL.createObjectURL file

    onSelect files

  render: ->
    {connectDropTarget, children} = @props

    props = _.omit @props, 'connectDropTarget', 'className', 'onChange', 'children'

    connectDropTarget <div className={@classes('file-input')} {...props}>
      <input ref="input" type="file" className="file-input_input" onChange={@onChange}/>
      {children}
    </div>

module.exports = DropTarget(NativeTypes.FILE, fileTarget, collectTarget)(FileInput)
