React = require 'react/addons'
Main = require './main'
Loader = require './loader'
CommonHeader = require './header/common'
RatingHeader = require './header/rating'
EditRatingHeader = require './header/edit_rating'
Popups = require './popups/popups'
Toastr = require './toastr/toastr'
FbRoot = require './fb_root'

{PropTypes} = React

Layout = React.createClass
  displayName: 'Layout'

  propTypes:
    children: PropTypes.node.isRequired
    header: PropTypes.string
    sectionSlug: PropTypes.string

  headers:
    common: CommonHeader
    editRating: EditRatingHeader
    rating: RatingHeader

  getDefaultProps: ->
    header: 'common'
    sectionSlug: ''

  header: ->
    {header} = @props

    Header = @headers[header]
    <Header/>

  render: ->
    {children, sectionSlug} = @props

    <div className="layout">
      {@header()}
      <Main sectionSlug={sectionSlug}>
        {children}
      </Main>
      <Popups/>
      <Toastr/>
      <Loader/>
      <FbRoot/>
    </div>

module.exports = Layout
