_ = require 'lodash'
React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

defaultOpts =
  prefix: true

ModelLink = (name, opts = {}) ->
  opts = _.defaults {}, opts, defaultOpts

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
    to = "/#{@slug()}"
    to = "/#{name}s#{to}" if opts.prefix
    Root = if @slug() then Link else 'span'

    <Root to={to} {...props}>
      {children}
    </Root>

module.exports = ModelLink
