_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
OnEsc = require '../../mixins/on_esc'
Popup = require './popup'
PopupActionCreators = require '../../../action_creators/popups'
PopupsStore = require '../../../stores/popups'

{PropTypes} = React
{PureRenderMixin} = React.addons

Popups = React.createClass
  displayName: 'Popups'

  mixins: [PureRenderMixin, OnEsc]

  propTypes:
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @onEsc @closeLastPopup

  closeLastPopup: ->
    {popups} = @props

    PopupActionCreators.remove _.last(popups)

  popups: ->
    {popups} = @props

    popups.map (popup) ->
      <Popup key={popup.cid} popup={popup}/>

  render: ->
    {popups} = @props

    classes = classNames 'popups', 'm-empty': _.isEmpty(popups)

    <div className={classes}>
      {@popups()}
    </div>

module.exports = Marty.createContainer Popups,
  listenTo: PopupsStore

  fetch: ->
    popups: PopupsStore.for(@).getAll()
