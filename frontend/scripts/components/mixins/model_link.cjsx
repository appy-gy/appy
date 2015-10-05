_ = require 'lodash'
React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

defaultOpts = (name) ->
  propTypes:
    "#{name}": PropTypes.object
    slug: PropTypes.string
    children: PropTypes.node
  prefix: ->
    "#{name}s"
  url: (props, {prefix}) ->
    slug = props.slug || props[name]?.slug
    url = "/#{slug}"
    url = "/#{prefix @props}#{url}" if _.isFunction prefix
    url

ModelLink = (name, opts = {}) ->
  opts = _.defaultsDeep opts, defaultOpts(name)
  {propTypes, url} = opts

  displayName: "#{_.camelCase name}Link"

  propTypes: propTypes

  getDefaultProps: ->
    children: null

  render: ->
    {children} = @props

    props = _.omit @props, name, 'slug', 'children'

    <Link to={url @props, opts} {...props}>
      {children}
    </Link>

module.exports = ModelLink
