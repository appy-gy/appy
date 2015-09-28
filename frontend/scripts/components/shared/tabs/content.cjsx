React = require 'react'
ReactRedux = require 'react-redux'
Nothing = require '../nothing'

{PropTypes} = React
{connect} = ReactRedux

TabContent = React.createClass
  displayName: 'TabContent'

  propTypes:
    id: PropTypes.string.isRequired
    queryKey: PropTypes.string.isRequired
    isDefault: PropTypes.bool.isRequired
    isActive: PropTypes.bool.isRequired
    children: PropTypes.node

  getDefaultProps: ->
    children: null

  render: ->
    {isActive, children} = @props

    return <Nothing/> unless isActive

    children

mapStateToProps = ({router}, {id, queryKey, isDefault}) ->
  tab = router.location.query?[queryKey]
  isActive: if tab? then tab == id else isDefault

module.exports = connect(mapStateToProps)(TabContent)
