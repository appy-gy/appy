_ = require 'lodash'
React = require 'react'
OnEsc = require '../../mixins/on_esc'
popupActions = require '../../../actions/popups'
ReactRedux = require 'react-redux'

{PropTypes} = React
{connect} = ReactRedux
{removePopup} = popupActions

Popup = React.createClass
  displayName: 'Popup'

  mixins: [OnEsc]

  propTypes:
    popup: PropTypes.object.isRequired

  componentWillMount: ->
    @onEsc @close

  close: ->
    @props.dispatch removePopup(@popup()) if @popup()?

  popup: ->
    {popups} = @props

    return if _.isEmpty popups
    _.last popups

  render: ->
    {popup} = @props
    <div className="popups_popup">
      <div className="popups_popup_content">
        {popup.content()}
      </div>
      <div className="popups_popup_close" onClick={@close}></div>
    </div>

  mapStateToProps = ({popups}) ->
    { popups }

module.exports = connect(mapStateToProps)(Popup)
