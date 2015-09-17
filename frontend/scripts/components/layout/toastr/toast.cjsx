React = require 'react'
ReactRedux = require 'react-redux'
toastActions = require '../../../actions/toasts'

{PropTypes} = React
{connect} = ReactRedux
{removeToast} = toastActions

Toast = React.createClass
  displayName: 'Toast'

  propTypes:
    dispatch: PropTypes.func.isRequired
    toast: PropTypes.object.isRequired

  componentWillMount: ->
    @queueRemove()

  remove: ->
    {dispatch, toast} = @props

    dispatch removeToast(toast)

  queueRemove: ->
    {toast} = @props

    return if @timerId?
    @unqueueRemove()
    @timerId = setTimeout @remove, toast.timeout

  unqueueRemove: ->
    return unless @timerId?
    clearTimeout @timerId
    @timerId = null

  render: ->
    {toast} = @props

    <div className="toastr_toast m-#{toast.type}" onClick={@remove} onMouseEnter={@unqueueRemove} onMouseLeave={@queueRemove}>
      {toast.content}
    </div>

module.exports = connect()(Toast)
