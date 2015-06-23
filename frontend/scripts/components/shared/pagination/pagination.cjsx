_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'

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
    {block} = @props

    _.map @windowRanges(), (range, position) =>
      classes = classNames "#{block}_window", "m-#{position}"

      <div key={position} className={classes}>
        {@links range}
      </div>

  prevPageLink: ->
    {link: Link, block, currentPage} = @props

    return if currentPage == 1

    <Link className="m-prev" block={block} page={currentPage - 1}>
      Предидущая
    </Link>

  nextPageLink: ->
    {link: Link, block, currentPage, pagesCount} = @props

    return if currentPage == pagesCount

    <Link className="m-next" block={block} page={currentPage + 1}>
      Следующая
    </Link>

  links: (range) ->
    {link: Link, block, currentPage} = @props

    range.map (page) ->
      isActive = page == currentPage

      <Link key={page} block={block} page={page} isActive={isActive}>
        {page}
      </Link>

  render: ->
    {block} = @props

    <div className={block}>
      {@prevPageLink()}
      {@windows()}
      {@nextPageLink()}
    </div>

module.exports = Pagination