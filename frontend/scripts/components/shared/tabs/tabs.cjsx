_ = require 'lodash'
React = require 'react/addons'
Title = require './title'

{PropTypes} = React

Tabs = React.createClass
  displayName: 'Tabs'

  propTypes:
    defaultTab: PropTypes.string.isRequired
    queryKey: PropTypes.string
    queryModificator: PropTypes.func
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    queryKey: 'tab'
    queryModificator: _.identity

  getInitialState: ->
    {defaultTab, queryKey, children} = @props
    {router} = @context

    activeTab: router.getCurrentQuery()[queryKey] || defaultTab

  activateTab: (id) ->
    {queryKey, queryModificator} = @props
    {router} = @context

    query = queryModificator _.defaults("#{queryKey}": id, router.getCurrentQuery())
    router.replaceWith router.getCurrentPathname(), {}, query
    @setState activeTab: id

  titles: ->
    {children} = @props
    {activeTab} = @state

    children.map (child, index) =>
      {id, title} = child.props
      active = id == activeTab
      onClick = _.partial @activateTab, id

      <Title key={id} text={title} active={active} onClick={onClick}/>

  tab: ->
    {children} = @props
    {activeTab} = @state

    _.find children, (child) -> child.props.id == activeTab

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_tabs">
      <div className="#{block}_tab-titles">
        {@titles()}
      </div>
      <div className="#{block}_tab-content">
        {@tab()}
      </div>
    </div>

module.exports = Tabs
