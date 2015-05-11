React = require 'react/addons'
Marty = require 'marty'
HeaderSectionsStore = require '../../../stores/header_sections'
Section = require './section'

{PropTypes} = React
{PureRenderMixin} = React.addons

Navigation = React.createClass
  displayName: 'Navigation'

  mixins: [PureRenderMixin]

  propTypes:
    sections: PropTypes.arrayOf(PropTypes.object).isRequired

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <Section key={section.id} section={section}/>

  render: ->
    <nav className="site-nav">
      {@sections()}
    </nav>

module.exports = Marty.createContainer Navigation,
  listenTo: HeaderSectionsStore

  fetch: ->
    sections: HeaderSectionsStore.for(@).getAll()

  pending: ->
    @done sections: []
