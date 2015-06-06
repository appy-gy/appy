_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Nothing = require '../shared/nothing'

{PropTypes} = React

RatingMenu = React.createClass
  displayName: 'RatingMenu'

  mixins: [Marty.createAppMixin()]

  render: ->
    <div className="rating_menu">{@props.children}</div>

module.exports = RatingMenu
