_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'

{PropTypes} = React
{connect} = ReactRedux

Loader = React.createClass
  displayName: 'Loader'

  propTypes:
    visible: PropTypes.bool.isRequired

  render: ->
    {visible} = @props

    classes = classNames 'layout_loader', 'm-hidden': not visible

    <div className={classes}></div>

mapStateToProps = ({loader}) ->
  _.pick loader, 'visible'

module.exports = connect(mapStateToProps)(Loader)
