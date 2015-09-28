React = require 'react'
ReactRedux = require 'react-redux'
Helmet = require 'react-helmet'
pageActions = require '../../actions/page'
Layout = require '../layout/layout'

{PropTypes} = React
{connect} = ReactRedux
{fetchPage} = pageActions

Page = React.createClass
  displayName: 'Page'

  propTypes:
    dispatch: PropTypes.func.isRequired
    page: PropTypes.object.isRequired
    pageSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchPage()

  fetchPage: ->
    @props.dispatch fetchPage(@props.pageSlug)

  render: ->
    {page, isFetched} = @props

    <Layout isLoading={not isFetched}>
      <Helmet title={page.title} />
      <div className="page" dangerouslySetInnerHTML={__html: page.body}></div>
    </Layout>

mapStateToProps = ({router, page}) ->
  page: page.item
  pageSlug: router.params.pageSlug
  isFetched: page.isFetched

module.exports = connect(mapStateToProps)(Page)
