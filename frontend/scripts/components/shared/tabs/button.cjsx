_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
classNames = require 'classnames'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxReactRouter

TabButton = React.createClass
  displayName: 'TabButton'

  propTypes:
    dispatch: PropTypes.func.isRequired
    id: PropTypes.string.isRequired
    queryKey: PropTypes.string.isRequired
    isDefault: PropTypes.bool.isRequired
    queryModificator: PropTypes.func
    pathname: PropTypes.string.isRequired
    query: PropTypes.object.isRequired
    isActive: PropTypes.bool.isRequired
    children: PropTypes.node

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    queryModificator: _.identity
    children: null

  activate: ->
    {dispatch, id, pathname, query, queryKey, queryModificator} = @props

    query = queryModificator _.defaults("#{queryKey}": id, query)
    dispatch replaceState(null, pathname, query)

  render: ->
    {isActive, children} = @props
    {block} = @context

    classes = classNames "#{block}_tab-button", 'm-active': isActive

    <div className={classes} onClick={@activate}>
      {children}
    </div>

mapStateToProps = ({router}, {id, queryKey, isDefault}) ->
  tab = router.location.query?[queryKey]
  pathname: router.location.pathname
  query: router.location.query || {}
  isActive: if tab? then tab == id else isDefault

module.exports = connect(mapStateToProps)(TabButton)
