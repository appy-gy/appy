Marty = require 'marty'
Constants = require '../constants'

class VotesActions extends Marty.ActionCreators
  create: (ratingItemId, kind) ->
    @app.votesApi.create(ratingItemId, kind).then ({body, ok}) =>
      return unless ok
      @dispatch Constants.CHANGE_RATING_ITEM, ratingItemId, vote: body.vote, mark: body.meta.mark

module.exports = VotesActions
