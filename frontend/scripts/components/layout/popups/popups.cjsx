_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
OnEsc = require '../../mixins/on_esc'
Popup = require './popup'

{PropTypes} = React

Popups = React.createClass
  displayName: 'Popups'

  mixins: [Marty.createAppMixin(), OnEsc]

  propTypes:
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @onEsc @closeLastPopup

  closeLastPopup: ->
    {popups} = @props

    @app.popupsActions.remove _.last(popups)

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
  listenTo: 'popupsStore'

  fetch: ->
    popups: @app.popupsStore.getAll()
