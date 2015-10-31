_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
Select = require 'react-select'
sectionActions = require '../../actions/sections'
ratingActions = require '../../actions/rating'
findInArray = require '../../helpers/find_in_array'
RatingUpdater = require '../mixins/rating_updater'

{PropTypes} = React
{connect} = ReactRedux
{fetchSections} = sectionActions
{changeRating, updateRating} = ratingActions

SectionSelect = React.createClass
  displayName: 'SectionSelect'

  mixins: [PureRendexMixin, RatingUpdater]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    sections: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @fetchSections()

  fetchSections: ->
    @props.dispatch fetchSections()

  changeSection: (sectionId) ->
    {dispatch, sections} = @props

    section = findInArray sections, sectionId

    dispatch changeRating({ section })
    @queueUpdate ->
      dispatch updateRating({ sectionId })

  options: ->
    {sections} = @props

    sections.map (section) ->
      value: section.id, label: section.name, color: section.color

  renderOption: ({label, color}) ->
    <div style={{color}}>
      {label}
    </div>

  render: ->
    {rating} = @props

    <Select placeholder="Выберите рубрику" value={rating.section?.id} options={@options()} searchable={false} clearable={false} valueRenderer={@renderOption} optionRenderer={@renderOption} onChange={@changeSection}/>

mapStateToProps = ({sections}) ->
  sections: sections.items

module.exports = connect(mapStateToProps)(SectionSelect)
