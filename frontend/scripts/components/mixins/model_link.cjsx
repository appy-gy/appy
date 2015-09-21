_ = require 'lodash'
React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

ModelLink = (name) ->
  displayName: "#{_.camelCase name}Link"

  propTypes:
    "#{name}": PropTypes.object
    slug: PropTypes.string
    children: PropTypes.node

  getDefaultProps: ->
    children: null

  slug: ->
    {slug} = @props
    object = @props[name]

    slug or object?.slug

  render: ->
    {children} = @props

    props = _.omit @props, name, 'slug', 'children'
    to = "/#{name}s/#{@slug()}"
    Root = if @slug() then Link else 'span'

    <Root to={to} {...props}>
      {children}
    </Root>

module.exports = ModelLink
