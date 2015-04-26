React = require 'react/addons'
Marty = require 'marty'
SectionsStore = require '../../stores/sections'

{PropTypes} = React
{PureRenderMixin} = React.addons

SectionsSelect = React.createClass
  displayName: 'SectionsSelect'

  mixins: [PureRenderMixin]

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <option key={section.id} value={section.id}>
        {section.name}
      </option>

  render: ->
    <select className="rating_section-name edit">
      {@sections()}
    </select>

module.exports = Marty.createContainer SectionsSelect,
  listenTo: SectionsStore

  fetch: ->
    sections: SectionsStore.for(@).getAll()
