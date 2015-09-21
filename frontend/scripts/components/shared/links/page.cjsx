React = require 'react'
ModelLink = require '../../mixins/model_link'

{PropTypes} = React

PageLink = React.createClass
  displayName: 'PageLink'

  mixins: [ModelLink]

  propTypes:
    page: PropTypes.object

  objectName: 'page'

module.exports = PageLink
