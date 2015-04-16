React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingItem = React.createClass
  displayName: 'RatingItem'

  render: ->
    <section className="rating-point">
      <div className="rating-point_title">
        <span className="rating-point_number">1</span>
        <span>Beyonce & Nicki Minaj ‘Flawless’</span>
      </div>
      <div className="rating-point_cover">
        <img src="http://lorempixel.com/870/400"/>
      </div>
      <div className="rating-point_description">
        <p>
          Душа моя озарена неземной радостью, как эти чудесные весенние утра, которыми я наслаждаюсь от всего сердца.
        </p>
        <p>
          Я совсем один и блаженствую в здешнем краю, словно созданном для таких, как я.
        </p>
        <p>
          Я так счастлив, мой друг, так упоен ощущением покоя, что искусство мое страдает от этого. Ни одного штриха не мог бы я сделать, а никогда не был таким большим художником, как в эти минуты. Я совсем один и блаженствую в здешнем краю, словно созданном для таких, как я.
        </p>
      </div>
      <div className="rating-point_actions">
        <div className="rating-point_minus ion-android-remove"></div>
        <div className="rating-point_mark">1234</div>
        <div className="rating-point_plus ion-android-add"></div>
      </div>
    </section>

module.exports = RatingItem
