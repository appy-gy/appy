React = require 'react/addons'
ModelLink = require '../../mixins/model_link'

{PropTypes} = React

UserLink = React.createClass
  displayName: 'UserLink'

  mixins: [ModelLink]

  propTypes:
    user: PropTypes.object

  objectName: 'user'

module.exports = UserLink
