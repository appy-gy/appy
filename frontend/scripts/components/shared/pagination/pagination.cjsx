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
    centralWindowSize: 5
    sideWindowsSize: 3

  windowRanges: ->
    {currentPage, pagesCount, centralWindowSize, sideWindowsSize} = @props

    leftWindow = [1..sideWindowsSize]
    rightWindow = [(pagesCount - sideWindowsSize)..pagesCount]

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

  links: (range) ->
    {link: Link, block, currentPage} = @props

    range.map (page) ->
      isActive = page == currentPage

      <Link key={page} block={block} page={page} isActive={isActive}/>

  render: ->
    {block} = @props

    <div className={block}>
      {@windows()}
    </div>

module.exports = Pagination
