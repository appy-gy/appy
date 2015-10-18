_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Helmet = require 'react-helmet'
Select = require 'react-select'
http = require '../../helpers/http'
OnEsc = require '../mixins/on_esc'
Layout = require '../layout/layout'
Result = require './result'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter

SearchPage = React.createClass
  displayName: 'SearchPage'

  mixins: [OnEsc]

  propTypes:
    dispatch: PropTypes.func.isRequired
    query: PropTypes.string.isRequired

  getInitialState: ->
    results: []

  componentWillMount: ->
    @search @props.query
    @onEsc -> history.back()

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

    <Layout header={false} showClose={true}>
      <Helmet title="Поиск"/>
      <div className="search">
        <input type="text" className="search_input" placeholder="Поиск" autoFocus value={query} onChange={@changeQuery}/>
        <div className="search_results">
          {@results()}
        </div>
      </div>
    </Layout>

mapStateToProps = ({router}) ->
  query: router.params.query || ''

module.exports = connect(mapStateToProps)(SearchPage)
