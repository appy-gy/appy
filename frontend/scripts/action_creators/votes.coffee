Marty = require 'marty'
VotesApi = require '../state_sources/votes'
Vote = require '../models/vote'
RatingItemConstants = require '../constants/rating_items'

class VoteActionCreators extends Marty.ActionCreators
  @id: 'VoteActionCreators'

  create: (ratingItemId, kind) ->
    VotesApi.create(ratingItemId, kind).then ({body, status}) =>
      return if status == 400
      vote = new Vote body.vote
      {mark} = body.meta
      @dispatch RatingItemConstants.CHANGE_RATING_ITEM, ratingItemId, { vote, mark }

module.exports = Marty.register VoteActionCreators
