React = require 'react/addons'
Router = require 'react-router'
Link = Router.Link

Subscription = React.createClass
  render: ->
    <div class="subscription">
      <div class="subscription_title">
        Мы можете подписаться на рассылку прямо сейчас:
      </div>
      <div class="subscription_input-wrapper">
        <input class="subscription_input" type="text" placeholder="Ваш e-mail"/>
        <div class='subscription_submit ion-arrow-right-c'>
        </div>
      </div>
    </div>

module.exports = Subscription
