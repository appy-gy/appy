React = require 'react/addons'
Listener = require '../../mixins/listener'
HeaderSectionsStore = require '../../../stores/header_sections'
Section = require './section'

{PureRenderMixin} = React.addons

Navigation = React.createClass
  displayName: 'Navigation'

  mixins: [PureRenderMixin, Listener]

  getInitialState: ->
    sections: @getSections()

  componentWillMount: ->
    @addListener HeaderSectionsStore.addChangeListener(@updateSections)

  getSections: ->
    HeaderSectionsStore.getAll()

  updateSections: ->
    @setState sections: @getSections()

  sections: ->
    {sections} = @state

    sections.when
      pending: ->
      done: (sections) ->
        sections.map (section) ->
          <Section key={section.id} section={section}/>

  render: ->
    <nav className="site-nav">
      {@sections()}
    </nav>

module.exports = Navigation
