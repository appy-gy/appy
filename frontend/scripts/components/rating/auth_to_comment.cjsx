React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
Login = require '../shared/auth/login'

AuthToComment = React.createClass
  displayName: 'AuthToComment'

  mixins: [PureRenderMixin]

  render: ->
    <div className="comments_auth-to-comment">
      <Login className="comments_auth-to-comment-button">
        Авторизуйтесь
      </Login>
      <div className="comments_auth-to-comment-body">
        чтобы оставить комментарий
      </div>
    </div>

module.exports = AuthToComment
