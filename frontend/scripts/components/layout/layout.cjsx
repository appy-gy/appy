React = require 'react/addons'
Main = require './main'
CommonHeader = require './header/common'
RatingHeader = require './header/rating'
Popups = require './popups/popups'
Toastr = require './toastr/toastr'

{PropTypes} = React

Layout = React.createClass
  displayName: 'Layout'

  propTypes:
    header: PropTypes.string
    children: PropTypes.node.isRequired

  headers:
    common: CommonHeader
    rating: RatingHeader

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
      <Toastr/>
    </div>

module.exports = Layout
