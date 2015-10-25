React = require 'react'
Rating = require './rating'
User = require './user'

resultTypes =
  rating: Rating
  user: User

Result = ({result}) ->
  Component = resultTypes[result.type]
  props = "#{result.type}": result

  <Component {...props}/>

module.exports = Result
