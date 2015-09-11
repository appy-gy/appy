_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
popupActions = require '../../../actions/popups'
OnEsc = require '../../mixins/on_esc'
Popup = require './popup'

{PropTypes} = React
{CSSTransitionGroup} = React.addons
{connect} = ReactRedux
{removePopup} = popupActions

Popups = React.createClass
  displayName: 'Popups'

  mixins: [OnEsc]

  propTypes:
    dispatch: PropTypes.func.isRequired
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

  componentWillMount: ->
    @onEsc @closeLastPopup

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
      <CSSTransitionGroup className="popups_popup-wrapper" transitionName="m">
        {@popupComponent()}
      </CSSTransitionGroup>
      <div className="popups_close" onClick={@closeLastPopup}></div>
    </div>

mapStateToProps = ({popups}) ->
  { popups }

module.exports = connect(mapStateToProps)(Popups)
