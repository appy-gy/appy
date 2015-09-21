React = require 'react'
ReactRedux = require 'react-redux'
pageActions = require '../../actions/page'
Loading = require '../mixins/loading'
Layout = require '../layout/layout'
Nothing = require '../shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{fetchPage} = pageActions

Page = React.createClass
  displayName: 'Page'

  mixins: [Loading]

  propTypes:
    dispatch: PropTypes.func.isRequired
    page: PropTypes.object.isRequired
    pageSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchPage()

  isLoading: ->
    not @props.isFetched

  fetchPage: ->
    @props.dispatch fetchPage(@props.pageSlug)

  render: ->
    {page} = @props

    return <Nothing/> if @isLoading()

    <Layout>
      <div className="page" dangerouslySetInnerHTML={__html: page.body}></div>
    </Layout>

mapStateToProps = ({router, page}) ->
  page: page.item
  pageSlug: router.params.pageSlug
  isFetched: page.isFetched

module.exports = connect(mapStateToProps)(Page)
