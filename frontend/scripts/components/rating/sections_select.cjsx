_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Select = require 'react-select'

{PropTypes} = React

SectionsSelect = React.createClass
  displayName: 'SectionsSelect'

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired
    object: PropTypes.object.isRequired

  contextTypes:
    canEdit: PropTypes.bool.isRequired

  updateSection: (sectionId) ->
    {object, actions} = @props

    @app[actions].update object.id, { sectionId }

  options: ->
    {sections} = @props

    sections.map (section) ->
      value: section.id, label: section.name

  render: ->
    {object} = @props
    {canEdit} = @context

    return <div>{object.section?.name}</div> unless canEdit

    <Select placeholder="Рубрика" value={object.section?.id} options={@options()} searchable={false} onChange={@updateSection}/>

module.exports = Marty.createContainer SectionsSelect,
  listenTo: 'sectionsStore'

  fetch: ->
    sections: @app.sectionsStore.getAll()
