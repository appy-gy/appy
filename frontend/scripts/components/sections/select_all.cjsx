React = require 'react/addons'
SectionsStore = require '../../stores/sections'
Listener = require '../mixins/listener'

SelectAll = React.createClass
  mixins: [Listener]

  getInitialState: ->
    sections: @getSections()

  componentWillMount: ->
    @addListener SectionsStore.addChangeListener @updateSections

  getSections: ->
    SectionsStore.getAll()

  updateSections: ->
    @setState sections: @getSections()

  render: ->
    {sections} = @state

    sections.when
      pending: ->
        <div className='pending'>Loading section...</div>
      failed: (error) ->
        <div className='error'>Failed to load section. {error.message}</div>
      done: (sections) ->
        <select className="rating_section-name edit">
          {sections.map (section) -> <option value={section.id}>{section.name}</option>}
        </select>

module.exports = SelectAll
