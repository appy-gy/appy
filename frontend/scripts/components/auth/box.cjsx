React = require 'react/addons'
Login = require './login'
Registration = require './registration'

Box = React.createClass
  render: ->
    <ul className="auth-box">
      <li><Login /></li>
      <li><Registration /></li>
    </ul>

module.exports = Box
