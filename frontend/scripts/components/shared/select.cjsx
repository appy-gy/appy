_ = require 'lodash'
React = require 'react/addons'

{PropTypes} = React

CustomSelect = React.createClass
  displayName: 'CustomSelect'

  propTypes:
    items: PropTypes.arrayOf(PropTypes.object).isRequired
    onChange: PropTypes.func.isRequired

  getInitialState: ->
    selectedItem: { name: '' }

  selectItem: (item) ->
    @setState selectedItem: item

  renderItems: ->
    {items} = @props

    items.map (item) =>
      <div onClick={_.bind @selectItem, _, item}>
        {item.name}
      </div>

  render: ->
    {selectedItem} = @state

    <div>
      {selectedItem.name}
      {@renderItems()}
    </div>

module.exports = CustomSelect
