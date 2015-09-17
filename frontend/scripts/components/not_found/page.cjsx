React = require 'react'
Router = require 'react-router'
CreateRating = require '../shared/ratings/create'
Registration = require '../shared/auth/registration'

{PropTypes} = React
{Link} = Router

NotFoundPage = React.createClass
  displayName: 'NotFoundPage'

  contextTypes:
    currentUser: PropTypes.object.isRequired

  button: ->
    {currentUser} = @context

    if currentUser.id?
      Component = CreateRating
      props = {}
      children = 'Создать рейтинг'
    else
      Component = Link
      props = to: 'root'
      children = <Registration>Зарегистрироваться</Registration>

    <Component className="not-found_button" {...props}>
      {children}
    </Component>

  render: ->
    <div className="not-found">
      <div className="not-found_content">
        <div className="not-found_title">404</div>
        <div className="not-found_text">
          Упс... Мы еще не разработали эту страницу, но ты можешь нам помочь!
        </div>
        {@button()}
        <div className="not-found_caption">
          <span>или </span>
          <Link to="/" className="not-found_link">
            на главную
          </Link>
        </div>
      </div>
    </div>

module.exports = NotFoundPage
