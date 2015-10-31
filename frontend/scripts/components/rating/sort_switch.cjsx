React = require 'react'
ReactRedux = require 'react-redux'
PureRendexMixin = require 'react-addons-pure-render-mixin'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
ratingItemsOrders = require '../../helpers/rating_items/orders'

{PropTypes} = React
{connect} = ReactRedux
{changeRatingItemsOrder} = ratingItemActions

SortSwitch = React.createClass
  displayName: 'SortSwitch'

  mixins: [PureRendexMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    order: PropTypes.string.isRequired

  buttons: ->
    {dispatch, order} = @props

    ratingItemsOrders.map ({type, name}) ->
      classes = classNames 'rating_sort-switch-button', 'm-active': order == type
      onClick = -> dispatch changeRatingItemsOrder(type)
      <div key={type} className={classes} onClick={onClick}>{name}</div>

  render: ->

    <div className="rating_sort-switch-wrap">
      <div className="rating_sort-switch">
        {@buttons()}
      </div>
    </div>

mapStateToProps = ({ratingItems}) ->
  order: ratingItems.order

module.exports = connect(mapStateToProps)(SortSwitch)
