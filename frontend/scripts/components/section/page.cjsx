_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Helmet = require 'react-helmet'
sectionActions = require '../../actions/section'
sectionRatingActions = require '../../actions/section_ratings'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchSection} = sectionActions
{fetchSectionRatings} = sectionRatingActions

Section = React.createClass
  displayName: 'Section'

  mixins: [RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    section: PropTypes.object.isRequired
    sectionSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired

  head:
    tech:
      title: 'Технологии - автомобили, телефоны, гаджеты, компьютеры, технологии, техника'
      description: 'Cамые интересные технологии, тюнинг, суперкары, обзоры телефонов, новости науки, сделай сам'
      keywords: 'автомобили, тюнинг, олдтаймеры, телефоны, гаджеты, компьютеры, технологии, техника'
    entertainment:
      title: 'Развлечения - игры, книги, кино, косплей, хобби'
      description: 'Интересные развлечения: новые фильмы, лучшие книги, игры для консолей, интересные видеоролики, смешное видео'
      keywords: 'смешные ролики, новые фильмы, что почитать, интересные книги, новинки кино, новые игры, косплей, коллекционирование'
    business:
      title: 'Бизнес - советы бизнесменам, свое дело, работа, секреты успеха'
      description: 'Интересно о бизнесе: как стать миллионером, истории успеха богатых людей, идеи для бизнеса, как открыть свое дело'
      keywords: 'советы бизнесменам, бизнес, успех, деньги, идеи для своего дела, идеи для бизнеса, знаменитые бизнесмены'
    lifestyle:
      title: 'Лайфстайл - путешествия, мода, здоровье, еда'
      description: 'Интересная жизнь: рассказы о путешествиях, интересных местах, куда поехать, модные тенденции, фитнес и здоровье, оригинальные рецепты'
      keywords: 'туры, путешествия, туризм, интересные маршруты, тренировки, диеты, полезная еда, необычные рецепты'
    mood:
      title: 'Настроение - секс, любовь, отношения, юмор, девушки, юноши, красота'
      description: 'Вдохновение и развлечения: самое интересное о любви, отношениях, красивых людях'
      keywords: 'любовь, брак, семья, вдохновение, хорошее настроение, истории об отношениях'
    noise:
      title: 'Шум - что угодно о чем угодно'
      description: 'Интересные факты, неожиданные открытия, удивительные вещи и истории со всего мира'
      keywords: 'факты, рейтинги, интересные штуки, удивительные явления, тайны, удивительный мир'

  componentWillMount: ->
    @fetchSection()

  componentDidUpdate: ->
    @fetchSection()

  meta: ->
    {sectionSlug} = @props

    [
      { name: 'description', content: @head[sectionSlug].description }
      { name: 'keywords', content: @head[sectionSlug].keywords }
    ]

  fetchSection: ->
    @props.dispatch fetchSection(@props.sectionSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchSectionRatings(@props.sectionSlug, page)

  changePage: (page) ->
    @props.dispatch replaceState(null, "/sections/#{@props.sectionSlug}", { page })

  previews: ->
    @ratings().map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    {sectionSlug, isFetched} = @props

    <Layout isLoading={not isFetched}>
      <Helmet title={@head[sectionSlug].title} meta={@meta()}/>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

mapStateToProps = ({router, sectionRatings, section}, {sectionSlug}) ->
  ratings: sectionRatings.items
  section: section.item
  sectionSlug: router.params.sectionSlug
  page: parseInt(router.location.query?.page || 1)
  pagesCount: sectionRatings.pagesCount
  isFetched: _.any [sectionRatings, section], 'isFetched'

module.exports = connect(mapStateToProps)(Section)
