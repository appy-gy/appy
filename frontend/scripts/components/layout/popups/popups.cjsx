React = require 'react/addons'
Popup = require './popup'
Listener = require '../../mixins/listener'
PopupsStore = require '../../../stores/popups'

{PureRenderMixin} = React.addons

Popups = React.createClass
  displayName: 'Popups'

  mixins: [PureRenderMixin, Listener]

  getInitialState: ->
    popups: @getPopups()

  componentWillMount: ->
    @addListener PopupsStore.addChangeListener(@updatePopups)

  getPopups: ->
    PopupsStore.getAll()

  updatePopups: ->
    @setState popups: @getPopups()

  popups: ->
    {popups} = @state

    popups.map (popup, index) ->
      <Popup key={index} popup={popup}/>

  render: ->
    <div className="popups">
      {@popups()}
    </div>

module.exports = Popups
