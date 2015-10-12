React = require 'react'
ReactRedux = require 'react-redux'
OnEsc = require '../../mixins/on_esc'
popupActions = require '../../../actions/popups'

{PropTypes} = React
{connect} = ReactRedux
{removePopup} = popupActions

Popup = React.createClass
  displayName: 'Popup'

  mixins: [OnEsc]

  propTypes:
    dispatch: PropTypes.func.isRequired
    popup: PropTypes.object.isRequired

  componentWillMount: ->
    @onEsc @close

  close: ->
    @props.dispatch removePopup(@props.popup)

  render: ->
    {popup} = @props
    <div className="popups_popup">
      <div className="popups_popup_content">
        {popup.content()}
      </div>
      <div className="popups_popup_close" onClick={@close}></div>
    </div>

module.exports = connect()(Popup)
