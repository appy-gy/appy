_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Select = require '../shared/select'

{PropTypes} = React

SectionsSelect = React.createClass
  displayName: 'SectionsSelect'

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired
    object: PropTypes.object.isRequired

  updateSection: (section) ->
    {object, actions} = @props

    @app[actions].update object.id, sectionId: section.id

  render: ->
    {sections, object} = @props

    <Select items={sections} value={object.section} onChange={@updateSection}/>

module.exports = Marty.createContainer SectionsSelect,
  listenTo: 'sectionsStore'

  fetch: ->
    sections: @app.sectionsStore.getAll()
