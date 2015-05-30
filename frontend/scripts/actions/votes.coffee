Marty = require 'marty'
Constants = require '../constants'
Vote = require '../models/vote'

class VotesActions extends Marty.ActionCreators
  create: (ratingItemId, kind) ->
    @app.votesApi.create(ratingItemId, kind).then ({body, status}) =>
      return if status == 400
      vote = new Vote body.vote
      {mark} = body.meta
      @dispatch Constants.CHANGE_RATING_ITEM, ratingItemId, { vote, mark }

module.exports = VotesActions
