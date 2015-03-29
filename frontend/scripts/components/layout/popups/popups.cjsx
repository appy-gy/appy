_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Popup = require './popup'
PopupsStore = require '../../../stores/popups'

{PropTypes} = React
{PureRenderMixin} = React.addons

Popups = React.createClass
  displayName: 'Popups'

  mixins: [PureRenderMixin]

  propTypes:
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

  popups: ->
    {popups} = @props

    popups.map (popup, index) ->
      <Popup key={index} popup={popup}/>

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
