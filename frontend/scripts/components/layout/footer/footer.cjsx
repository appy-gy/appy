_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
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
    isBlured: PropTypes.bool.isRequired

  componentWillMount: ->
    @props.dispatch fetchFooterPages()

  pages: ->
    {pages} = @props

    pages.map (page) ->
      <PageLink key={page.id} page={page} className="layout_footer-link">
        {page.title}
      </PageLink>

  render: ->
    {isBlured} = @props

    classes = classNames 'layout_footer', 'm-blured': isBlured

    <div className={classes}>
      <div className="layout_footer-logo">
      </div>
      <div className="layout_footer-left">
        {@pages()}
      </div>
      <div className="layout_footer-right">
        <a className="layout_footer-link" href="https://www.facebook.com/appysite" target="_blank">facebook</a>
        <a className="layout_footer-link" href="https://vk.com/appygy" target="_blank">вконтакте</a>
      </div>
    </div>

mapStateToProps = ({footerPages}) ->
  pages: footerPages.items

module.exports = connect(mapStateToProps)(Footer)
