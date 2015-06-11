_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
OnClickElsewhere = require '../mixins/on_click_elsewhere'

{PropTypes} = React

itemShape = PropTypes.shape(id: PropTypes.any.isRequired, name: PropTypes.string.isRequired)

CustomSelect = React.createClass
  displayName: 'CustomSelect'

  mixins: [OnClickElsewhere]

  propTypes:
    value: itemShape
    items: PropTypes.arrayOf(itemShape).isRequired
    onChange: PropTypes.func.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  getInitialState: ->
    expanded: false

  componentDidMount: ->
    @onClickElsewhere @unexpand

  unexpand: ->
    @setState expanded: false

  expand: ->
    {expanded} = @state

    @setState expanded: true

  items: ->
    {items, onChange} = @props
    {block} = @context

    items.map (item) =>
      <div className="#{block}_select-options-item" key={item.id} onClick={_.partial onChange, item}>
        {item.name}
      </div>

  render: ->
    {value} = @props
    {expanded} = @state
    {block} = @context
    optionClasses = classNames "#{block}_select-options", 'g-hidden': !expanded

    <div className="#{block}_select" onClick={@expand}>
      <div className="#{block}_select-selected-value">{value.name}</div>
      <div className={optionClasses}>
        {@items()}
      </div>
    </div>

module.exports = CustomSelect
