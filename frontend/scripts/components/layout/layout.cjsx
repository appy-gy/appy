React = require 'react'
Main = require './main'
Loader = require './loader'
CommonHeader = require './header/common'
RatingHeader = require './header/rating'
EditRatingHeader = require './header/edit_rating'
Popups = require './popups/popups'
Toastr = require './toastr/toastr'
FbRoot = require './fb_root'
Footer = require './footer/footer'

{PropTypes} = React

Layout = React.createClass
  displayName: 'Layout'

  propTypes:
    header: PropTypes.string
    onLogoClick: PropTypes.func
    children: PropTypes.node.isRequired

  childContextTypes:
    headerExpanded: PropTypes.bool.isRequired
    triggerHeader: PropTypes.func.isRequired
    onLogoClick: PropTypes.func.isRequired

  headers:
    common: CommonHeader
    editRating: EditRatingHeader
    rating: RatingHeader

  getDefaultProps: ->
    header: 'common'
    onLogoClick: ->

  getInitialState: ->
    headerExpanded: false

  getChildContext: ->
    {onLogoClick} = @props
    {headerExpanded} = @state

    { headerExpanded, @triggerHeader, onLogoClick }

  triggerHeader: ->
    @setState headerExpanded: not @state.headerExpanded

  header: ->
    {header} = @props

    Header = @headers[header]
    <Header/>

  render: ->
    {children} = @props

    <div className="layout">
      {@header()}
      <Main>
        {children}
      </Main>
      <Footer/>
      <Popups/>
      <Toastr/>
      <Loader/>
      <FbRoot/>
    </div>

module.exports = Layout
