React = require 'react/addons'
HeaderSectionsStore = require '../../stores/header_sections_store'
Section = require './section'

Navigation = React.createClass
  getInitialState: ->
    sections: @getSections()

  getSections: ->
    HeaderSectionsStore.getSections()

  render: ->
    {sections} = @state

    items = sections.map (section) ->
      <Section key={section.id} section={section}/>

    <div className="navigation">
      {items}
    </div>

module.exports = Navigation
