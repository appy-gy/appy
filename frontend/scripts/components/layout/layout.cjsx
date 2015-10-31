React = require 'react'
isClient = require '../../helpers/is_client'
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
    onClose: null
    children: null

  getInitialState: ->
    headerExpanded: false
    searchVisible: false
    showLoader: false

  getChildContext: ->
    {onLogoClick} = @props
    {headerExpanded, searchVisible} = @state

    { headerExpanded, @triggerHeader, searchVisible, @triggerSearch, onLogoClick }

  componentWillMount: ->
    @setupLoaderTimeout() if @props.isLoading

  componentWillReceiveProps: ({isLoading}) ->
    {isLoading: prevIsLoading} = @props
    {showLoader} = @state

    return if isLoading == prevIsLoading
    return @setupLoaderTimeout() if isLoading
    @clearLoaderTimeout()
    @setState showLoader: false if showLoader

  triggerHeader: ->
    @setState headerExpanded: not @state.headerExpanded

  triggerSearch: ->
    @setState searchVisible: not @state.searchVisible

  setupLoaderTimeout: ->
    return unless isClient()
    @loaderTimeout = setTimeout =>
      @setState showLoader: true
    , 1000

  clearLoaderTimeout: ->
    return unless @loaderTimeout?
    clearTimeout @loaderTimeout
    @loaderTimeout = null

  shouldShowClose: ->
    @props.onClose or @state.searchVisible

  onClose: ->
    if @state.searchVisible then @triggerSearch() else @props.onClose()

  header: ->
    {header} = @props

    return unless header
    Header = @headers[header]
    <Header/>

  search: ->
    <Search/> if @state.searchVisible

  loader: ->
    <Loader/> if @state.showLoader

  footer: ->
    <Footer/> if @props.showFooter

  close: ->
    <Close onClose={@onClose}/> if @shouldShowClose()

  content: ->
    @props.children unless @props.isLoading

  render: ->
    {header, children} = @props

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
