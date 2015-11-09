React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Sticky = require 'react-sticky'

{PropTypes} = React
{connect} = ReactRedux
{goBack} = ReduxRouter

Close = React.createClass
  displayName: 'Close'

  propTypes:
    dispatch: PropTypes.func.isRequired

  goBack: ->
    # FIXME: redux-router acts strange
    # when you try to go back on esc keypress
    setImmediate => @props.dispatch goBack()

  render: ->
    <Sticky className="rating_close-wrap" stickyClass="m-sticky" stickyStyle={{}}>
      <div className="rating_close" onClick={@goBack}></div>
    </Sticky>

module.exports = connect()(Close)
