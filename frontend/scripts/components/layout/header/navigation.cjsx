React = require 'react/addons'
ReactRedux = require 'react-redux'
headerSectionActions = require '../../../actions/header_sections'
Section = require './section'

{PropTypes} = React
{connect} = ReactRedux
{fetchHeaderSections} = headerSectionActions

Navigation = React.createClass
  displayName: 'Navigation'

  propTypes:
    dispatch: PropTypes.func.isRequired
    sections: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @fetchHeaderSections()

  fetchHeaderSections: ->
    @props.dispatch fetchHeaderSections()

  sections: ->
    {sections} = @props

    sections.map (section) ->
      <Section key={section.id} section={section}/>

  render: ->
    <nav className="site-nav">
      {@sections()}
    </nav>

mapStateToProps = ({headerSections}) ->
  sections: headerSections.items

module.exports = connect(mapStateToProps)(Navigation)
