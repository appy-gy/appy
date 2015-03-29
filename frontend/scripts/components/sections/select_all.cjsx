React = require 'react/addons'
Marty = require 'marty'
SectionsStore = require '../../stores/sections'

{PropTypes} = React
{PureRenderMixin} = React.addons

SelectAll = React.createClass
  displayName: 'SelectAll'

  mixins: [PureRenderMixin]

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <option value={section.id}>
        {section.name}
      </option>

  render: ->
    <select className="rating_section-name edit">
      {@sections()}
    </select>

module.exports = Marty.createContainer SelectAll,
  listenTo: SectionsStore

  fetch: ->
    sections: SectionsStore.getAll()
