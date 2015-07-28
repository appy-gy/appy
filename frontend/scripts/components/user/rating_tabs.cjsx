_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
canSeeRatingDrafts = require '../../helpers/ratings/can_see_drafts'
Ratings = require './ratings'
Tabs = require '../shared/tabs/tabs'
Tab = require '../shared/tabs/tab'

{PropTypes} = React

RatingTabs = React.createClass
  displayName: 'RatingTabs'

  propTypes:
    currentUser: PropTypes.object.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  statuses: ['published', 'draft']
  statusNames:
    published: 'Опубликованные'
    draft: 'Черновики'

  resetPage: (query) ->
    delete query.page
    query

  tabs: ->
    {user} = @context

    @statuses.map (status) =>
      name = @statusNames[status]
      count = user["#{status}RatingsCount"]

      <Tab key={status} id={status} title="#{name} (#{count})">
        <Ratings status={status}/>
      </Tab>

  content: ->
    {currentUser} = @props
    {user} = @context

    return <Ratings status="published"/> unless canSeeRatingDrafts currentUser, user

    <Tabs defaultTab="published" queryKey="status" queryModificator={@resetPage}>
      {@tabs()}
    </Tabs>

  render: ->
    {page} = @context

    <div className="user-ratings">
      {@content()}
    </div>

module.exports = Marty.createContainer RatingTabs,
  listenTo: 'currentUserStore'

  fetch: ->
    currentUser: @app.currentUserStore.get()
