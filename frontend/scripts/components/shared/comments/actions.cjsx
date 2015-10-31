_ = require 'lodash'
React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
Open = require './open'
Answer = require './answer'

{PropTypes} = React

Actions = React.createClass
  displayName: 'CommentActions'

  mixins: [PureRenderMixin]

  propTypes:
    comment: PropTypes.object.isRequired
    types: PropTypes.object.isRequired

  types:
    open: Open
    answer: Answer

  actions: ->
    {comment, types} = @props

    _.map types, (props, type) =>
      Comp = @types[type]

      <Comp key={type} comment={comment} {...props}/>

  render: ->
    <div className="comment_actions">
      {@actions()}
    </div>

module.exports = Actions
