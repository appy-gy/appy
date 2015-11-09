React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  mixins: [PureRendexMixin]

  componentDidMount: ->
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "//yastatic.net/share/share.js"
    script.async = true
    ReactDOM.findDOMNode(@).appendChild script

  render: ->
    <div dangerouslySetInnerHTML={{__html: "<div class='yashare-auto-init' data-yashareL10n='ru' data-yashareType='small' data-yashareQuickServices='vkontakte,facebook,twitter' data-yashareTheme='counter'></div>"}} />

module.exports = ShareButtons
