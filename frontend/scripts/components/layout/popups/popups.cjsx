_ = require 'lodash'
React = require 'react'
CSSTransitionGroup = require 'react-addons-css-transition-group'
ReactRedux = require 'react-redux'
popupActions = require '../../../actions/popups'
OnEsc = require '../../mixins/on_esc'
Popup = require './popup'

{PropTypes} = React
{connect} = ReactRedux
{removePopup} = popupActions

Popups = React.createClass
  displayName: 'Popups'

  mixins: [OnEsc]

  propTypes:
    dispatch: PropTypes.func.isRequired
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @onEsc
      cb: @closeLastPopup
      use: => not _.isEmpty @props.popups
      priority: 1

  closeLastPopup: ->
    @props.dispatch removePopup(@popup()) if @popup()?

  popup: ->
    {popups} = @props

    return if _.isEmpty popups
    _.last popups

  popupComponent: ->
    popup = @popup()
    return unless popup?
    <Popup key={popup.cid} popup={popup}/>

  render: ->
    <div className="popups">
      <CSSTransitionGroup className="popups_popup-wrapper" transitionName="m" transitionEnterTimeout={250} transitionLeaveTimeout={250}>
        {@popupComponent()}
      </CSSTransitionGroup>
      <div className="popups_close" onClick={@closeLastPopup}></div>
    </div>

mapStateToProps = ({popups}) ->
  { popups }

module.exports = connect(mapStateToProps)(Popups)
