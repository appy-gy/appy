React = require 'react/addons'
Marty = require 'marty'
SectionsStore = require '../../stores/sections'

{PropTypes} = React

SelectAll = React.createClass
  displayName: 'SelectAll'

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired
    object: PropTypes.object.isRequired

  updateSection: (event) ->
    {object, actionCreator} = @props

    actionCreator.save object, sectionId: event.target.value

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <option key={section.id} value={section.id}>
        {section.name}
      </option>

  render: ->
    <select className="rating_section-name edit" onChange={@updateSection}>
      {@sections()}
    </select>

module.exports = Marty.createContainer SelectAll,
  listenTo: SectionsStore

  fetch: ->
    sections: SectionsStore.for(@).getAll()
