# Стайл гайд

## Sass

* Придерживайтесь БЭМ
* Ставь отступы между селекторами:
  ```sass
  .block
    display: flex

    &_element-1
      color: red

    &_element-2
      color: green
  ```

## CoffeeScript

### Marty

* Не указывай тип файла в него название, то есть `stores/records`, а не `stores/record_stores`

#### Stores

* Названия методов в зависимости от назначения:
  * Грузит страницу - `getPage`
  * Грузит "все" записи, не принимая никаких параметров - `getAll`
  * Грузит одну записать, принимая id - `get`
  * Перезаписывает весь state - `set`
  * Добавляет одну или несколько записей к state - `append`
* Используй общию сторейдж для хранению отдельных записей и массивов записей из одной модели
* При обновление сторейджа старайся использовать `React.addons.update`
* Если собираешся использовать `React.addons.update` достань его заранее:
  ```coffee
  {update} = React.addons
  ...
  append: (records) ->
    @state = update @state, $push: records
  ```

#### State sources

Названия методов в зависимости от назначения:
* Грузит страницу - `loadPage`
* Грузит "все" записи, не принимая никаких параметров - `loadAll`
* Грузит одну записать, принимая id - `load`

#### Action creators

Не пиши тут логику

#### State mixins

Не используй

### Helpers

* Если пишешь, хелперы нужные только для какой-то конкретной страницы создавай для них отдельную папку
* В целом старайся не создавать хелперы в корне директории

### Routes

* Задавай обязательно всем роутам `name`
* Чаще всего в нашем случае вложенные роуты не нужны, помни об этом
* Для каждого корневого роута создавай свою директорию в components. Для вложенных роутов создавай вложенные директории

### Components

* Задавай всем компонентам `displayName`
* Если это page, то используй название директории в `displayName`, в остальных случаях используй в `displayName` название файла в camelCase
* Если компоненты принимает `props`, то прописывай для них типы в `propTypes`
* У каждого аттрибута в `propTypes` должен или быть проставлен `isRequired` или для него должно быть определенно дефолтное значение в методе `getDefaultProps`
* Все `props` и `state`, которые собираешься использовать в метода, доставай и сохраняй в локальные переменные в начале метода:
  ```coffee
  render: ->
    {someProp} = @props
    {someState} = @state

    code...
  ```
* Используй миксин `Listener` для подписки на сторейджи. Он автоматически удалит все твои листерены при анмаунте компонента
  ```coffee
  componentWillMount: ->
    @addListener SomeStore.addChangeListener(@updateSomething)
  ```
* Придерживайся такой схемы при подписке на сторейдж:
  ```coffee
  getInitialState: ->
    cups: @getCups()

  componentWillMount: ->
    @addListener CupsStore.addChangeListener(@updateCups)

  getCups: ->
    CupsStore.getAll()

  updateCups: ->
    @setState cups: @getCups()
  ```
* Не забывай добавлять `PureRenderMixin` к компонентам
* Если тебе нужно хитро составить имена классов для элемента используй `classNames`
* Доставай `PropTypes` и `PureRenderMixin` заранее:
  ```coffee
  React = require 'react/addons'

  {PropTypes} = React
  {PureRenderMixin} = React.addons

  Comp = React.createClase
    displayName: 'Comp'

    mixins: [PureRenderMixin]

    propTypes:
      prop: PropTypes.string.isRequired
  ```
* Больше компонентов лучше, чем меньше компонентов
