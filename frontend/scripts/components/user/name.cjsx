React = require 'react/addons'

{PropTypes} = React

Name = React.createClass
  displayName: 'Name'

  contextTypes:
    user: PropTypes.object.isRequired

  render: ->
    {user} = @context

    <div className="user-profile_name">
      {user.name}
    </div>

module.exports = Name
