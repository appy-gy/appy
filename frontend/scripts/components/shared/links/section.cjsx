React = require 'react'
ModelLink = require '../../mixins/model_link'

{PropTypes} = React

SectionLink = React.createClass
  displayName: 'SectionLink'

  mixins: [ModelLink]

  propTypes:
    section: PropTypes.object

  objectName: 'section'

module.exports = SectionLink
