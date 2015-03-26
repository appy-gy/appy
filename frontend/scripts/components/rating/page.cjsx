React = require 'react/addons'
Listener = require '../mixins/listener'
RatingsStore = require '../../stores/ratings'
RatingsActionCreator = require '../../action_creators/ratings'
SectionsSelect = require '../../components/sections/select_all'
RatingTitle = require '../../components/rating/title'

{PureRenderMixin} = React.addons

Rating = React.createClass
  mixins: [Listener, PureRenderMixin]

  getInitialState: ->
    rating: @getRating()

  componentWillMount: ->
    @addListener RatingsStore.addChangeListener(@updateRating)

  getRating: ->
    {ratingId} = @props
    RatingsStore.get ratingId

  updateRating: ->
    @setState rating: @getRating()

  changeRatingField: (field, value) ->
    {rating} = @state

    changes = "#{field}": value
    RatingsActionCreator.change rating.result.id, changes

  rating: ->
    {rating} = @state

    rating.when
      pending: ->
        <div className='pending'>Loading rating...</div>
      failed: (error) ->
        <div className='error'>Failed to load rating. {error.message}</div>
      done: (rating) =>
        <div>
          <header className="rating_header">
            <div className="meta rating_meta">
              <div className="meta_item rating_item like-counter">
                <div className="meta_icon rating_icon ion-heart"></div>
                <div className="meta_text rating_text">433</div>
              </div>
              <div className="meta_item rating_item comments-counter">
                <div className="meta_icon rating_icon ion-chatbubble"></div>
                <div className="meta_text rating_text">433</div>
              </div>
              <div className="meta_item rating_item date">
                <div className="meta_text">{rating.createdAt.format('D MMMM YYYY')}</div>
              </div>
            </div>
            <div className="image-selector">
              <div className="image-selector_icon"></div>
              <div className="image-select_text">Загрузить изображение</div>
            </div>
            <a href="/" className="rating_section-name">{rating.section.name}</a>
            <SectionsSelect />
            <RatingTitle title={rating.title} onChange={_.partial(@changeRatingField, 'title')}/>
          </header>
          <div className="rating_description">
            Сразу хочу сказать, что этот рейтинг не полный, и скорее, личный. В общем,  тут несколько строк пояснения о рейтинге вообще.
          </div>
          <div>
            <textarea className="rating_description edit"></textarea>
            <div className="cancel">
              Отменить
            </div>
            <div className="accept">
              Сохранить
            </div>
          </div>
          <div className="tags rating_tags">
            <span className="tag rating_tag">фантазия</span>
            <span className="tag rating_tag">девушки</span>
          </div>
          <a href="/" className="rating_author">
            Иван Ивановввввв
          </a>
          <div className="rating_line"></div>
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <section className="rating-point">
            <div className="rating-point_title">
              <span className="rating-point_number">#1 </span>
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
          <div className="rating_line"></div>
          <div className="rating-like">
            <div className="rating-like_burst-1"></div>
            <div className="rating-like_burst-2"></div>
            <div className="rating-like_content ion-thumbsup"></div>
          </div>
          <div className="rating-share">
            <div className="rating-share_button facebook">
              <div className="rating-share_icon ion-social-facebook"></div>
              <div className="rating-share_text">Нравится</div>
            </div>
            <div className="rating-share_button vk">
              <div className="rating-share_icon"></div>
              <div className="rating-share_text">Поделиться</div>
            </div>
            <div className="rating-share_button twitter">
              <div className="rating-share_icon ion-social-twitter"></div>
              <div className="rating-share_text">Твитнуть</div>
            </div>
          </div>
          <div className="comments">
            <div className="comments_header">
              Комментарии
            </div>
            <div className="comment">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <div className="comment_content">
                <span className="comment_username">Роман Оганесян</span>
                <span className="comment_text">Проснувшись однажды утром после беспокойного сна</span>
                <div className="comment_date">28 минут назад</div>
              </div>
            </div>
            <div className="comment">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <div className="comment_content">
                <span className="comment_username">Роман Оганесян</span>
                <span className="comment_text">Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
                <div className="comment_date">28 минут назад</div>
              </div>
            </div>
            <div className="comment">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <div className="comment_content">
                <span className="comment_username">Роман Оганесян</span>
                <span className="comment_text">ПроснувшисьоднаждыПроснувшисьоднаждыутромпослебеспокойногоснаГрегоЗамзадваоывдалодлвыоадПроснувшисьоднаждыутромпослебеспокойного</span>
                <div className="comment_date">28 минут назад</div>
              </div>
            </div>
            <div className="comment">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <div className="comment_content">
                <span className="comment_username">Роман Оганесян</span>
                <span className="comment_text">ПроснувшисьоднаждыутромпослебеспокойногоснаГрегоЗамзадваоывдалодлвыоадПроснувшисьоднаждыутромпослебеспокойного сна,<br/> Грегор Замза дваоывдало<br/><br/> длвыоад Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
                <div className="comment_date">28 минут назад</div>
              </div>
            </div>
            <div className="comment">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <div className="comment_content">
                <span className="comment_username">Роман Оганесян</span>
                <span className="comment_text">Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
                <div className="comment_date">28 минут назад</div>
              </div>
            </div>
            <div className="comment-form">
              <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
              <textarea className="comment_textarea"></textarea>
            </div>
          </div>
        </div>

  render: ->
    <article className="rating">
      {@rating()}
    </article>

module.exports = Rating
