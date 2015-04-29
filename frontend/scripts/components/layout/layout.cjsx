React = require 'react/addons'
Main = require './main'
CommonHeader = require './header/common'
Popups = require './popups/popups'

{PropTypes} = React

Layout = React.createClass
  displayName: 'Layout'

  propTypes:
    header: PropTypes.string
    children: PropTypes.node.isRequired

  headers:
    common: CommonHeader

  getDefaultProps: ->
    header: 'common'

  header: ->
    {header} = @props

    Header = @headers[header]
    <Header/>

  render: ->
    {children} = @props

    <div className='layout'>
      {@header()}
      <Main>
        {children}
      </Main>
      <Popups/>
    </div>

module.exports = Layout
