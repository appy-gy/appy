_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Helmet = require 'react-helmet'
Select = require 'react-select'
http = require '../../helpers/http'
Layout = require '../layout/layout'
Result = require './result'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter

SearchPage = React.createClass
  displayName: 'SearchPage'

  propTypes:
    dispatch: PropTypes.func.isRequired
    query: PropTypes.string.isRequired

  getInitialState: ->
    results: []

  componentWillMount: ->
    @search @props.query

  changeQuery: (event) ->
    {dispatch} = @props
    {value: query} = event.target

    newUrl = "/search/#{query}".replace(/\/$/, '')
    dispatch replaceState(null, newUrl)

    @search query

  search: (query) ->
    return @setState results: [] if _.isEmpty query

    http.get('search/global', params: { query }).then ({data}) =>
      # User has changed the search query during the request
      return unless query == @props.query
      @setState results: data.results

  results: ->
    {results} = @state

    results.map (result) ->
      <Result key="#{result.type}_#{result.id}" result={result}/>

  render: ->
    {query} = @props

    <Layout header={false} showFooter={false} showClose={true}>
      <Helmet title="Поиск"/>
      <div className="search">
        <h1 className="search_title">Поиск</h1>
        <div className="search_input-wrap">
          <input type="text" className="search_input" placeholder="Просто начните вводить то, что ищете" autoFocus value={query} onChange={@changeQuery}/>
        </div>
        <div className="search_results">
          {@results()}
        </div>
      </div>
    </Layout>

mapStateToProps = ({router}) ->
  query: router.params.query || ''

module.exports = connect(mapStateToProps)(SearchPage)
