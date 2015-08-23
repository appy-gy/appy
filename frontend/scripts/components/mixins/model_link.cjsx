_ = require 'lodash'
React = require 'react/addons'
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

    Root = if @slug() then Link else 'span'

    <Root to={@objectName} params={"#{@objectName}Slug": @slug()} {...props}>
      {children}
    </Root>

module.exports = ModelLink
