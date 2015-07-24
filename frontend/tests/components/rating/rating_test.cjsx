_ = require 'lodash'
chai = require 'chai'
moment = require 'moment'
React = require 'react/addons'
testTree = require 'react-test-tree'
mockComponents = require '../../helpers/mock_components'
RatingContainer = require '../../../scripts/components/rating/rating'
Header = require '../../../scripts/components/rating/header'
UserLink = require '../../../scripts/components/shared/links/user'

{expect} = chai
{InnerComponent: Rating} = RatingContainer

describe 'Rating', ->
  describe 'elements visibility', ->
    before ->
      @restoreComponents = mockComponents Header, UserLink

    after ->
      @restoreComponents()

    beforeEach ->
      @rating = createdAt: moment(), imageUrl: (->), user: {}
      @ratingItems = []

    context 'rating is published', ->
      beforeEach ->
        @rating.status = 'published'
        @ratingTree = testTree <Rating rating={@rating} ratingItems={@ratingItems}/>, app: {}, canEdit: true

      _.each deleteButton: false, publishButton: false, authorLink: true, likeButton: true, shareButtons: true, (visible, name) ->
        it "#{if visible then 'shows' else 'hides'} #{_.startCase name}", ->
          expectation = expect @ratingTree[name]
          expectation = expectation.not if visible
          expectation.to.be.undefined

    context 'rating is draft', ->
      beforeEach ->
        @rating.status = 'draft'
        @ratingTree = testTree <Rating rating={@rating} ratingItems={@ratingItems}/>, app: {}, canEdit: true

      _.each deleteButton: true, publishButton: true, authorLink: false, likeButton: false, shareButtons: false, (visible, name) ->
        it "#{if visible then 'shows' else 'hides'} #{_.startCase name}", ->
          expectation = expect @ratingTree[name]
          expectation = expectation.not if visible
          expectation.to.be.undefined
