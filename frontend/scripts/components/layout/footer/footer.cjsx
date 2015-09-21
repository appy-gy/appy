React = require 'react'
PageLink = require '../../shared/links/page'

Footer = React.createClass
  displayName: 'Footer'

  render: ->
    <div className="layout_footer">
      <div className="layout_footer-logo">
      </div>
      <div className="layout_footer-left">
        <PageLink slug="about" className="layout_footer-link">О проекте</PageLink>
        <PageLink slug="ads" className="layout_footer-link">Рекламодателям</PageLink>
      </div>
      <div className="layout_footer-right">
        <PageLink slug="blog" className="layout_footer-link">Блог</PageLink>
        <PageLink slug="flow" className="layout_footer-link">Поток</PageLink>
      </div>
    </div>

module.exports = Footer
