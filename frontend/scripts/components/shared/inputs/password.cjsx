_ = require 'lodash'
React = require 'react'
classNames = require 'classnames'
Classes = require '../../mixins/classes'

{PropTypes} = React

PasswordInput = React.createClass
  displayName: 'PasswordInput'

  mixins: [Classes]

  contextTypes:
    block: PropTypes.string.isRequired

  getInitialState: ->
    showPassword: false

  triggerShowPassword: ->
    {showPassword} = @state

    @setState showPassword: not showPassword

  render: ->
    {showPassword} = @state
    {block} = @context

    props = _.omit @props, 'className'
    inputType = if showPassword then 'text' else 'password'
    showPasswordClasses = classNames "#{block}_show-password", 'm-active': showPassword

    <div className="#{block}_input-wrapper m-password">
      <input ref="input" type={inputType} className="#{block}_input m-password" {...props}/>
      <div ref="trigger" className={showPasswordClasses} onClick={@triggerShowPassword}></div>
    </div>

module.exports = PasswordInput
