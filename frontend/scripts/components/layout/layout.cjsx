React = require 'react/addons'
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
    children: PropTypes.node.isRequired
    header: PropTypes.string

  headers:
    common: CommonHeader
    editRating: EditRatingHeader
    rating: RatingHeader

  getDefaultProps: ->
    header: 'common'

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
