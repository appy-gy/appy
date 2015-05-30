React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

Toast = React.createClass
  displayName: 'Toast'

  mixins: [Marty.createAppMixin()]

  propTypes:
    toast: PropTypes.object.isRequired

  componentWillMount: ->
    @queueRemove()

  remove: ->
    {toast} = @props

    @app.toastsActions.remove toast

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

module.exports = Toast
