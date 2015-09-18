_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
Title = require './title'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxReactRouter

Tabs = React.createClass
  displayName: 'Tabs'

  propTypes:
    dispatch: PropTypes.func.isRequired
    tab: PropTypes.string.isRequired
    pathname: PropTypes.string.isRequired
    query: PropTypes.object.isRequired
    queryModificator: PropTypes.func
    children: PropTypes.node.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    queryModificator: _.identity

  activateTab: (id) ->
    {dispatch, pathname, query, queryModificator} = @props

    query = queryModificator _.defaults(tab: id, query)
    dispatch replaceState(null, pathname, query)

  titles: ->
    {tab, children} = @props

    children.map (child, index) =>
      {id, title} = child.props
      active = id == tab
      onClick = _.partial @activateTab, id

      <Title key={id} text={title} active={active} onClick={onClick}/>

  activeTab: ->
    {tab, children} = @props

    _.find children, (child) -> child.props.id == tab

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_tabs">
      <div className="#{block}_tab-titles">
        {@titles()}
      </div>
      <div className="#{block}_tab-content">
        {@activeTab()}
      </div>
    </div>

mapStateToProps = ({router}, {defaultTab}) ->
  tab: router.location.query?.tab || defaultTab
  pathname: router.location.pathname
  query: router.location.query || {}

module.exports = connect(mapStateToProps)(Tabs)
