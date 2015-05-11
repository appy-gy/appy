classNames = require 'classnames'

Classes =
  classes: ->
    {className} = @props

    classNames className, arguments...

module.exports = Classes
