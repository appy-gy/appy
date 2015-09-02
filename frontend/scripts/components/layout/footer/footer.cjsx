React = require 'react/addons'

{PureRenderMixin} = React.addons

Footer = React.createClass
  displayName: 'Footer'

  mixins: [PureRenderMixin]

  render: ->
    <div className="layout_footer">
      <div className="layout_footer-left">
        <a href="/" className="layout_footer-link">О проекте</a>
        <a href="/" className="layout_footer-link">Рекламодателям</a>
      </div>
      <div className="layout_footer-logo">
      </div>
      <div className="layout_footer-right">
        <a href="/" className="layout_footer-link">Блог</a>
        <a href="/" className="layout_footer-link">Поток</a>
      </div>
    </div>

module.exports = Footer
