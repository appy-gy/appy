_ = require 'lodash'
React = require 'react'
classNames = require 'classnames'
withIndexKeys = require '../../../helpers/react/with_index_keys'

{PropTypes} = React

Pagination = React.createClass
  displayName: 'Pagination'

  propTypes:
    block: PropTypes.string
    currentPage: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired
    link: PropTypes.func.isRequired
    centralWindowSize: PropTypes.number
    sideWindowsSize: PropTypes.number

  getDefaultProps: ->
    block: 'pagination'
    centralWindowSize: 7
    sideWindowsSize: 1

  windowRanges: ->
    {currentPage, pagesCount, centralWindowSize, sideWindowsSize} = @props

    leftWindowEnd = Math.min pagesCount, sideWindowsSize
    leftWindow = [1..leftWindowEnd]

    rightWindowStart = Math.max 1, pagesCount - sideWindowsSize + 1
    rightWindow = [rightWindowStart..pagesCount]

    centralWindowSideSize = (centralWindowSize - 1) / 2
    centralWindowStart = Math.max 1, currentPage - centralWindowSideSize
    centralWindowEnd = Math.min pagesCount, currentPage + centralWindowSideSize
    centralWindow = [centralWindowStart..centralWindowEnd]

    unless _(centralWindow).intersection(leftWindow).isEmpty()
      centralWindow = _.union leftWindow, centralWindow
      leftWindow = null
    unless _(centralWindow).intersection(rightWindow).isEmpty()
      centralWindow = _.union centralWindow, rightWindow
      rightWindow = null

    _.pick left: leftWindow, central: centralWindow, right: rightWindow, _.isArray

  windows: ->
    {block, pagesCount} = @props

    return if pagesCount <= 1

    _.map @windowRanges(), (range, position) =>
      classes = classNames "#{block}_window", "m-#{position}"

      <div key={position} refCollection="#{position}Window" className={classes}>
        {@links range}
      </div>

  prevPageLink: ->
    {link: Link, block, currentPage, pagesCount} = @props

    available = pagesCount > 1 and currentPage != 1
    classes = classNames 'm-prev', 'm-hidden': not available

    <Link ref="prevPageLink" className={classes} block={block} page={currentPage - 1}>
    </Link>

  nextPageLink: ->
    {link: Link, block, currentPage, pagesCount} = @props

    available = pagesCount > 1 and currentPage != pagesCount
    classes = classNames 'm-next', 'm-hidden': not available

    <Link ref="nextPageLink" className={classes} block={block} page={currentPage + 1}>
    </Link>

  links: (range) ->
    {link: Link, block, currentPage} = @props

    range.map (page) ->
      isActive = page == currentPage

      <Link key={page} block={block} page={page} isActive={isActive}>
        {page}
      </Link>

  content: ->
    {pagesCount, block} = @props

    return if pagesCount <= 1

    withIndexKeys [
      @prevPageLink()
      <div className="#{block}_windows">
        {@windows()}
      </div>
      @nextPageLink()
    ]

  render: ->
    {block} = @props

    <div className={block}>
      {@content()}
    </div>

module.exports = Pagination
