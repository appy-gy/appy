React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
ratingItemsOrders = require '../../helpers/rating_items/orders'

{connect} = ReactRedux
{changeRatingItemsOrder} = ratingItemActions

SortSwitch = ({dispatch, order}) ->
  buttons = ratingItemsOrders.map ({type, name}) ->
    classes = classNames 'rating_sort-switch-button', 'm-active': order == type
    onClick = -> dispatch changeRatingItemsOrder(type)
    <div key={type} className={classes} onClick={onClick}>{name}</div>

  <div className="rating_sort-switch-wrap">
    <div className="rating_sort-switch">
      {buttons}
    </div>
  </div>

mapStateToProps = ({ratingItems}) ->
  order: ratingItems.order

module.exports = connect(mapStateToProps)(SortSwitch)
