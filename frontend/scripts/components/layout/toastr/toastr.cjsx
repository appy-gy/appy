React = require 'react/addons'
ReactRedux = require 'react-redux'
Toast = require './toast'

{PropTypes} = React
{connect} = ReactRedux

Toastr = React.createClass
  displayName: 'Toastr'

  propTypes:
    toasts: PropTypes.arrayOf(PropTypes.object).isRequired

  toasts: ->
    {toasts} = @props

    toasts.map (toast) ->
      <Toast key={toast.cid} toast={toast}/>

  render: ->
    <div className="toastr">
      {@toasts()}
    </div>

mapStateToProps = ({toasts}) ->
  { toasts }

module.exports = connect(mapStateToProps)(Toastr)
