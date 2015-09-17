React = require 'react'
Router = require 'react-router'

Subscription = React.createClass
  displayName: 'Subscription'

  render: ->
    <div className="subscription">
      <div className="subscription_title">
        Вы можете подписаться на рассылку прямо сейчас:
      </div>
      <div className="subscription_input-wrapper">
        <input className="subscription_input" type="text" placeholder="Ваш e-mail"/>
        <div className="subscription_submit">
        </div>
      </div>
    </div>

module.exports = Subscription
