React = require 'react/addons'

ShareButtons = React.createClass
  displayName: 'ShareButtons'

  componentDidMount: ->
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "//share.pluso.ru/pluso-like.js"
    script.async = true
    @getDOMNode().appendChild script

  render: ->
    <div className="pluso" data-background="transparent" data-options="big,square,line,horizontal,counter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter"></div>

module.exports = ShareButtons
