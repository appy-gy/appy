_ = require 'lodash'
React = require 'react'
Select = require 'react-select'
classNames = require 'classnames'
http = require '../../../helpers/http'
HtmlStyle = require '../../shared/html_style'
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

    classes = classNames 'search', 'm-filled': not _.isEmpty(query)

    <div className={classes}>
      <HtmlStyle style={overflow: 'hidden'}/>
      <div className="search_cover"/>
      <div className="search_content">
        <div className="search_header">
          <h1 className="search_title">Поиск</h1>
          <input type="text" className="search_input" placeholder="Просто начните вводить то, что ищете" autoFocus value={query} onChange={@changeQuery}/>
        </div>
        <div className="search_results">
          {@results()}
        </div>
      </div>
    </div>

module.exports = Search
