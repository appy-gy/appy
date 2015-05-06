React = require 'react/addons'

{PropTypes} = React

Toast = React.createClass
  displayName: 'Toast'

  propTypes:
    toast: PropTypes.object.isRequired

  render: ->
    {toast} = @props

    <div className="toastr-toast">
      {toast.content}
    </div>
