React = require 'react'
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
      <div className="site-nav_item m-search">
        <div className="site-nav_icon">
        </div>
        <div className="site-nav_text">
          Поиск
        </div>
      </div>
    </nav>


mapStateToProps = ({headerSections}) ->
  sections: headerSections.items

module.exports = connect(mapStateToProps)(Navigation)
