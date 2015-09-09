_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
KeepScroll = require '../../mixins/keep_scroll'

{PropTypes} = React

ShowMore = React.createClass
  displayName: 'ShowMore'

  mixins: [KeepScroll]

  contextTypes:
    router: PropTypes.func.isRequired
    page: PropTypes.number.isRequired
    loadPage: PropTypes.func.isRequired
    changeVisiblePages: PropTypes.func.isRequired

  getInitialState: ->
    loading: false

  loadMore: ->
    {router, page, loadPage, changeVisiblePages} = @context

    @setState loading: true

    loadPage(page + 1).toPromise().then =>
      @setState loading: false
      changeVisiblePages (pages) -> pages.add page + 1

    setImmediate =>
      params = _.defaults page: page + 1, router.getCurrentParams()
      @keepScroll ->
        router.replaceWith 'ratings', params, router.getCurrentQuery()

  render: ->
    {loading} = @state

    classes = classNames 'previews_show-more', 'm-loading': loading
    <div className="previews_show-more-wrap">
      <div className={classes} onClick={@loadMore}>
        <div className="previews_show-more-icon">
        </div>
        <div className="previews_show-more-text">
          Хочу еще больше
        </div>
      </div>
    </div>

module.exports = ShowMore
