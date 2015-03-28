React = require 'react/addons'
Router = require 'react-router'

{PureRenderMixin} = React.addons

Subscription = React.createClass
  displayName: 'Subscription'

  mixins: [PureRenderMixin]

  render: ->
    <div className="subscription">
      <div className="subscription_title">
        Вы можете подписаться на рассылку прямо сейчас:
      </div>
      <div className="subscription_input-wrapper">
        <input className="subscription_input" type="text" placeholder="Ваш e-mail"/>
        <div className='subscription_submit ion-arrow-right-c'>
        </div>
      </div>
    </div>

module.exports = Subscription
