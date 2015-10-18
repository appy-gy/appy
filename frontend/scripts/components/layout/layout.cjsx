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
    header: PropTypes.oneOf ['common', 'rating', 'editRating', false]
    isLoading: PropTypes.bool
    onLogoClick: PropTypes.func
    children: PropTypes.node

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
    isLoading: false
    onLogoClick: ->
    children: null

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

    return unless header
    Header = @headers[header]
    <Header/>

  loader: ->
    <Loader/> if @props.isLoading

  content: ->
    @props.children unless @props.isLoading

  render: ->
    {header, children} = @props

    <div className="layout">
      {@header()}
      <Main hasHeader={!!header}>
        {@content()}
      </Main>
      <Footer/>
      <Popups/>
      <Toastr/>
      {@loader()}
      <FbRoot/>
    </div>

module.exports = Layout
