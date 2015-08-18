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
      value: section.id, label: section.name, color: section.color

  renderOption: ({label, color}) ->
    <div style={{color}}>
      {label}
    </div>

  render: ->
    {object} = @props
    {canEdit} = @context

    sectionNameStyles = _.pick object.section, 'color'

    return <div className="rating_section-name" style={sectionNameStyles}>{object.section?.name}</div> unless canEdit

    <Select placeholder="Рубрика" value={object.section?.id} options={@options()} searchable={false} valueRenderer={@renderOption} optionRenderer={@renderOption} onChange={@updateSection}/>

module.exports = Marty.createContainer SectionsSelect,
  listenTo: 'sectionsStore'

  fetch: ->
    sections: @app.sectionsStore.getAll()
