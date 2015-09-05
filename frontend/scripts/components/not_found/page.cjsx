React = require 'react/addons'

NotFoundPage = React.createClass
  displayName: 'NotFoundPage'

  render: ->
    <div className="not-found">
      <div className="not-found_content">
        <div className="not-found_title">404</div>
        <div className="not-found_text">
          Упс... Мы еще не разработали эту страницу, но ты можешь нам помочь!
        </div>
        <div className="not-found_button">
          Создать рейтинг
        </div>
        <div className="not-found_caption">
          <span>или </span>
          <a className="not-found_link" href="/">на главную</a>
        </div>
      </div>
    </div>

module.exports = NotFoundPage
