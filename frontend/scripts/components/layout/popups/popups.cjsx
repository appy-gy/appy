_ = require 'lodash'
React = require 'react'
CSSTransitionGroup = require 'react-addons-css-transition-group'
ReactRedux = require 'react-redux'
Popup = require './popup'

{PropTypes} = React
{connect} = ReactRedux

Popups = React.createClass
  displayName: 'Popups'

  propTypes:
    dispatch: PropTypes.func.isRequired
    popups: PropTypes.arrayOf(PropTypes.object).isRequired

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
    </div>

mapStateToProps = ({popups}) ->
  { popups }

module.exports = connect(mapStateToProps)(Popups)
