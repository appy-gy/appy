React = require 'react'
Main = require './main'
Loader = require './loader'
Close = require './close'
CommonHeader = require './header/common'
RatingHeader = require './header/rating'
EditRatingHeader = require './header/edit_rating'
Search = require './search/search'
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
    showFooter: PropTypes.bool
    showClose: PropTypes.bool
    onClose: PropTypes.func
    children: PropTypes.node

  childContextTypes:
    headerExpanded: PropTypes.bool.isRequired
    triggerHeader: PropTypes.func.isRequired
    searchVisible: PropTypes.bool.isRequired
    triggerSearch: PropTypes.func.isRequired
    onLogoClick: PropTypes.func.isRequired

  headers:
    common: CommonHeader
    editRating: EditRatingHeader
    rating: RatingHeader

  getDefaultProps: ->
    header: 'common'
    isLoading: false
    onLogoClick: ->
    showFooter: true
    showClose: false
    onClose: -> console.log 'TODO: implement default onClose for the layout component'
    children: null

  getInitialState: ->
    headerExpanded: false
    searchVisible: false

  getChildContext: ->
    {onLogoClick} = @props
    {headerExpanded, searchVisible} = @state

    { headerExpanded, @triggerHeader, searchVisible, @triggerSearch, onLogoClick }

  triggerHeader: ->
    @setState headerExpanded: not @state.headerExpanded

  triggerSearch: ->
    @setState searchVisible: not @state.searchVisible

  header: ->
    {header} = @props

    return unless header
    Header = @headers[header]
    <Header/>

  search: ->
    <Search/> if @state.searchVisible

  loader: ->
    <Loader/> if @props.isLoading

  footer: ->
    <Footer/> if @props.showFooter

  close: ->
    <Close onClose={@props.onClose}/> if @props.showClose

  content: ->
    @props.children unless @props.isLoading

  render: ->
    {header, onClose, children} = @props

    <div className="layout">
      {@header()}
      <Main hasHeader={!!header}>
        {@content()}
      </Main>
      {@footer()}
      {@close()}
      {@search()}
      <Popups/>
      <Toastr/>
      {@loader()}
      <FbRoot/>
    </div>

module.exports = Layout
