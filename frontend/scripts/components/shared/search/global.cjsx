React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Select = require 'react-select'
http = require '../../../helpers/http'

{PropTypes} = React
{connect} = ReactRedux
{pushState} = ReduxRouter

GlobalSearch = React.createClass
  displayName: 'GlobalSearch'

  propTypes:
    dispatch: PropTypes.func.isRequired

  toOptions: (results) ->
    results.map (result) ->
      label = result.title || result.name
      { label, value: "#{result.type}-#{result.id}", result}

  loadOptions: (query, callback) ->
    http.get('search/global', params: { query }).then ({data}) =>
      callback null, options: @toOptions(data.results)

  openResult: (newValue, [{result}]) ->
    @props.dispatch pushState(null, "/#{result.type}s/#{result.slug}")

  renderOption: ({result}) ->
    <div>
      {result.title || result.name}
    </div>

  render: ->
    <Select placeholder="Поиск" noResultsText="Ничего такого нет" searchPromptText="Начните вводить" searchingText="Поиск..." autoload={false} matchProp="label" asyncOptions={@loadOptions} value="" optionRenderer={@renderOption} onChange={@openResult}/>

module.exports = connect()(GlobalSearch)
