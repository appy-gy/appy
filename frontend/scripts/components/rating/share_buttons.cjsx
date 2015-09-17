React = require 'react'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  componentDidMount: ->
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "//share.pluso.ru/pluso-like.js"
    script.async = true
    @getDOMNode().appendChild script

  render: ->
    <div className="pluso rating_share" data-background="transparent" data-options="big,square,line,horizontal,counter,sepcounter=1,theme=14" data-services="vkontakte,facebook,twitter, odnoklassniki"></div>

module.exports = ShareButtons
