React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  mixins: [PureRendexMixin]

  componentDidMount: ->
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "//share.pluso.ru/pluso-like.js"
    script.async = true
    ReactDOM.findDOMNode(@).appendChild script

  render: ->
    <div className="pluso rating_share" data-background="transparent" data-options="big,square,line,horizontal,counter,sepcounter=1,theme=14" data-services="vkontakte,facebook,twitter, odnoklassniki"></div>

module.exports = ShareButtons
