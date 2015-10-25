_ = require 'lodash'
React = require 'react'
Select = require 'react-select'
http = require '../../../helpers/http'
Result = require './result'

{PropTypes} = React

Search = React.createClass
  displayName: 'Search'

  getInitialState: ->
    query: ''
    results: []

  changeQuery: (event) ->
    {value: query} = event.target

    @setState { query }
    @search query

  search: (query) ->
    return @setState results: [] if _.isEmpty query

    http.get('search/global', params: { query }).then ({data}) =>
      # User has changed the search query during the request
      return unless query == @state.query
      @setState results: data.results

  results: ->
    {results} = @state

    results.map (result) ->
      <Result key="#{result.type}_#{result.id}" result={result}/>

  render: ->
    {query} = @state

    <div className="search">
      <div className="search_cover"/>
      <div className="search_content">
        <h1 className="search_title">Поиск</h1>
        <input type="text" className="search_input" placeholder="Просто начните вводить то, что ищете" autoFocus value={query} onChange={@changeQuery}/>
        <div className="search_results">
          {@results()}
        </div>
      </div>
    </div>

module.exports = Search
