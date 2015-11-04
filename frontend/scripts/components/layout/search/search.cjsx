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

  propTypes:
    onClose: PropTypes.func.isRequired

  getInitialState: ->
    query: ''
    onGoing: false
    results: []

  changeQuery: (event) ->
    {value: query} = event.target

    @setState { query, onGoing: true }
    @search query

  search: (query) ->
    return @setState results: [] if _.isEmpty query

    http.get('search/global', params: { query }).then ({data}) =>
      # User has changed the search query during the request
      return unless query == @state.query
      @setState onGoing: false, results: data.results

  nothingFound: ->
    {query, onGoing, results} = @state

    return if _.isEmpty(query) or onGoing or not _.isEmpty(results)

    <div className="search_nothing-found">
      Ничего не найдено
    </div>

  results: ->
    {results} = @state

    results.map (result) ->
      <Result key="#{result.type}_#{result.id}" result={result}/>

  render: ->
    {onClose} = @props
    {query} = @state

    classes = classNames 'search', 'm-filled': not _.isEmpty(query)

    <div className={classes}>
      <HtmlStyle style={overflow: 'hidden'}/>
      <div className="search_cover"/>
      <div className="search_close" onClick={onClose}/>
      <div className="search_content">
        <h1 className="search_title">Поиск</h1>
        <input type="text" className="search_input" placeholder="Просто начните вводить то, что ищете" autoFocus value={query} onChange={@changeQuery}/>
        {@nothingFound()}
        <div className="search_results">
          {@results()}
        </div>
      </div>
    </div>

module.exports = Search
