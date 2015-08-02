_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
KeepScroll = require '../mixins/keep_scroll'

{PropTypes} = React

ShowMore = React.createClass
  displayName: 'ShowMore'

  mixins: [Marty.createAppMixin(), KeepScroll]

  contextTypes:
    router: PropTypes.func.isRequired
    page: PropTypes.number.isRequired

  getInitialState: ->
    loading: false

  loadMore: ->
    {router, page} = @context

    @setState loading: true

    @app.ratingsStore.getPage(page + 1).toPromise().then =>
      @setState loading: false

    setImmediate =>
      params = _.defaults page: page + 1, router.getCurrentParams()
      @keepScroll ->
        router.replaceWith 'ratings', params, router.getCurrentQuery()

  render: ->
    {loading} = @state

    classes = classNames 'previews_show-more', 'm-loading': loading

    <div className={classes} onClick={@loadMore}>
      Показать еще
    </div>

module.exports = ShowMore
