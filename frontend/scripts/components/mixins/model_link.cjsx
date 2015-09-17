_ = require 'lodash'
React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

ModelLink =
  propTypes:
    slug: PropTypes.string
    children: PropTypes.node

  getDefaultProps: ->
    children: null

  slug: ->
    {slug} = @props
    object = @props[@objectName]

    slug or object?.slug

  render: ->
    {children} = @props

    props = _.omit @props, @objectName, 'slug', 'children'
    to = "/#{@objectName}s/#{@slug()}"
    Root = if @slug() then Link else 'span'

    <Root to={to} {...props}>
      {children}
    </Root>

module.exports = ModelLink
