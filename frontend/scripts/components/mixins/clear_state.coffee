_ = require 'lodash'
isClient = require '../../helpers/is_client'
constantize = require '../../helpers/constantize'

if isClient()
  reducers = require '../../reducers'

actions = ['rating', 'ratings', 'ratingItems', 'ratingComments',
  'similarRatings', 'mainPageRatings', 'section', 'sectionRatings', 'user',
  'userRatings', 'userComments', 'page', 'tag', 'tagRatings'].map (name) ->
    type: "CLEAR_#{constantize name}", payload: null

ClearState =
  componentWillUpdate: (nextProps) ->
    return unless isClient()

    {dispatch, currentUser, params} = @props
    {currentUser: nextCurrentUser, params: nextParams} = nextProps

    return if currentUser.id == nextCurrentUser.id and _.isEqual(params, nextParams)
    actions.each (action) -> dispatch action

module.exports = ClearState
