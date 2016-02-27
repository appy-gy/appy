_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
isClient = require '../../helpers/is_client'
Main = require './main'
Loader = require './loader'
CommonHeader = require './header/common'
RatingHeader = require './header/rating'
EditRatingHeader = require './header/edit_rating'
Search = require './search/search'
Popups = require './popups/popups'
Toastr = require './toastr/toastr'
FbRoot = require './fb_root'
Footer = require './footer/footer'
NotFound = require '../not_found/page'

{PropTypes} = React
{connect} = ReactRedux

Layout = React.createClass
  displayName: 'Layout'

  propTypes:
    popups: PropTypes.arrayOf(PropTypes.object).isRequired
    header: PropTypes.oneOf ['common', 'rating', 'editRating', false]
    isLoading: PropTypes.bool
    onLogoClick: PropTypes.func
    showFooter: PropTypes.bool
    children: PropTypes.node
    isFound: PropTypes.bool.isRequired

  childContextTypes:
    headerExpanded: PropTypes.bool.isRequired
    triggerHeader: PropTypes.func.isRequired
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
    children: null
    isFound: true

  getInitialState: ->
    headerExpanded: false
    searchVisible: false
    showLoader: false

  getChildContext: ->
    {onLogoClick} = @props
    {headerExpanded} = @state

    { headerExpanded, @triggerHeader, @triggerSearch, onLogoClick }

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

  shouldBlur: ->
    return unless isClient()
    not Modernizr.touchevents and (@state.searchVisible or not _.isEmpty(@props.popups))

  header: ->
    {header} = @props

    return unless header

    Header = @headers[header]
    <Header isBlured={@shouldBlur()}/>

  search: ->
    <Search onClose={@triggerSearch}/> if @state.searchVisible

  loader: ->
    <Loader/> if @state.showLoader

  footer: ->
    {showFooter} = @props

    <Footer isBlured={@shouldBlur()}/> if showFooter

  page: ->
    {popups, header} = @props

    <div className="layout">
      {@header()}
      <Main hasHeader={!!header} isBlured={@shouldBlur()}>
        {@content()}
      </Main>
      {@footer()}
      {@search()}
      <Popups popups={popups}/>
      <Toastr/>
      {@loader()}
      <FbRoot/>
    </div>

  content: ->
    {children, isLoading} = @props

    children unless isLoading

  render: ->
    {isFound} = @props

    return <NotFound/> unless isFound

    @page()


mapStateToProps = ({popups}) ->
  { popups }

module.exports = connect(mapStateToProps)(Layout)
