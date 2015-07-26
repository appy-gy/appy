_ = require 'lodash'
React = require 'react/addons'
Form = require './form'
Open = require './open'
Answer = require './answer'

{PropTypes} = React

Actions = React.createClass
  displayName: 'CommentActions'

  propTypes:
    types: PropTypes.object.isRequired

  types:
    open: Open
    answer: Answer

  actions: ->
    {types} = @props

    _.map types, (props, type) =>
      Comp = @types[type]

      <Comp key={type} ref={type} {...props}/>

  render: ->
    <div className="comment_actions">
      {@actions()}
    </div>

module.exports = Actions
