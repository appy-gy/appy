isClient = require '../../helpers/is_client'
Likely = require('ilyabirman-likely') if isClient()
React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  mixins: [PureRendexMixin]

  componentDidMount: ->
    Likely ReactDOM.findDOMNode(@)

  render: ->
    <div className="likely likely-big">
      <div className="twitter">Твитнуть</div>
      <div className="facebook">Поделиться</div>
      <div className="vkontakte">Поделиться</div>
    </div>

module.exports = ShareButtons
