_ = require 'lodash'
isClient = require '../../helpers/is_client'
constantize = require '../../helpers/constantize'

if isClient()
  reducers = require '../../reducers'

actions = ['rating', 'ratings', 'ratingItems', 'ratingComments',
  'similarRatings', 'section', 'sectionRatings', 'user', 'userRatings',
  'userComments', 'page'].map (name) ->
    type: "CLEAR_#{constantize name}", payload: null

ClearState =
  componentWillUpdate: (nextProps) ->
    return unless isClient()

    {dispatch, params} = @props
    {params: nextParams} = nextProps

    return if _.isEqual params, nextParams
    actions.each (action) -> dispatch action

module.exports = ClearState
