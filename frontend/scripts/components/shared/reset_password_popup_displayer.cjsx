_ = require 'lodash'
React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
popupActions = require '../../actions/popups'
buildPopup = require '../../helpers/popups/build'
ResetPasswordPopup = require './popups/reset_password'
Nothing = require './nothing'

{PropTypes} = React
{connect} = ReactRedux
{pushState} = ReduxRouter
{appendPopup} = popupActions

ResetPasswordPopupDisplayer = React.createClass
  displayName: 'ResetPasswordPopupDisplayer'

  mixins: [PureRenderMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    pathname: PropTypes.string.isRequired
    query: PropTypes.object.isRequired

  componentWillMount: ->
    {dispatch, pathname, query} = @props

    token = query.reset_password_token

    return unless token?

    popup = buildPopup
      type: 'resetPassword'
      content: -> <ResetPasswordPopup token={token}/>

    dispatch pushState(null, pathname, _.omit(query, 'reset_password_token'))
    dispatch appendPopup(popup)

  render: ->
    <Nothing/>

mapStateToProps = ({router}) ->
  pathname: router.location.pathname
  query: router.location.query || {}

module.exports = connect(mapStateToProps)(ResetPasswordPopupDisplayer)
