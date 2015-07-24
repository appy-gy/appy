_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
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
  listenTo: 'headerSectionsStore'

  fetch: ->
    sections: @app.headerSectionsStore.getAll()

  pending: (props) ->
    @done _.defaults({}, props, sections: [])
