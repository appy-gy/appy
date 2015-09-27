_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
footerPageActions = require '../../../actions/footer_pages'
PageLink = require '../../shared/links/page'

{PropTypes} = React
{connect} = ReactRedux
{fetchFooterPages} = footerPageActions

Footer = React.createClass
  displayName: 'Footer'

  propTypes:
    dispatch: PropTypes.func.isRequired
    pages: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @props.dispatch fetchFooterPages()

  leftPages: ->
    @pages _.take(@props.pages, 2)

  rightPages: ->
    @pages _.slice(@props.pages, 2, 2)

  pages: (pages) ->
    pages.map (page) ->
      <PageLink key={page.id} page={page} className="layout_footer-link">
        {page.title}
      </PageLink>

  render: ->
    <div className="layout_footer">
      <div className="layout_footer-logo">
      </div>
      <div className="layout_footer-left">
        {@leftPages()}
      </div>
      <div className="layout_footer-right">
        {@rightPages()}
      </div>
    </div>

mapStateToProps = ({footerPages}) ->
  pages: footerPages.items

module.exports = connect(mapStateToProps)(Footer)
