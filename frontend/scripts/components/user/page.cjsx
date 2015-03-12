React = require 'react/addons'
Router = require 'react-router'
Link = Router.Link

User = React.createClass
  render: ->
    {user} = @props

    <div className="user-profile">
      <header className="user-profile_header">
        <div className="user-profile_avatar">
        </div>
        <div className="user-profile_info">
          <div className="user-profile_name">
            Александра Билялетдинова
          </div>
          <div className="user-profile_socials">
            <div className="user-profile_social m-fb">
            </div>
            <div className="user-profile_social m-insta">
            </div>
          </div>
        </div>
      </header>
      <section className="user-profile_tabs">
        <input id="tab1" name="radio" className="user-profile_tabs-radio" type="radio" defaultChecked/>
        <input id="tab2" name="radio" className="user-profile_tabs-radio" type="radio"/>
        <div className="user-profile_tabs-nav">
          <label id="label1" for="tab1" className="user-profile_tabs-nav-item">
            Рейтинги
          </label>
          <label id="label2" for="tab2" className="user-profile_tabs-nav-item">
            Комментарии
          </label>
        </div>
        <div className="user-profile_tab-content-wrapper">
          <div id="content1" className="user-profile_tab-content">
            <h2 className="user-profile_tab-title">Ваши рейтинги<span> (34)</span></h2>
            <div className="">
              <p>
                У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!
              </p>
              <a href='/' className="button">
                Создать рейтинг
              </a>
            </div>
          </div>
          <div id="content2" className="user-profile_tab-content">
            <h2 className="user-profile_tab-title">Ваши комментарии<span> (323424)</span></h2>
          </div>
        </div>
      </section>
    </div>

module.exports = User
