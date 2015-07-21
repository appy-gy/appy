_ = require 'lodash'
AbstractApplication = require './abstract_application'
typesMap = require './helpers/marty/types_map'

context = require.context './', true, /(actions|queries|sources|stores)\/(.*?)\.coffee$/

class Application extends AbstractApplication
  constructor: (options) ->
    super options

    context.keys().forEach (key) =>
      [type, name] = _.tail key.split('/')
      type = typesMap[type] || type
      name = name.split('.')[0]
      fullname = "#{name}_#{type}"
      @register _.camelCase(fullname), context(key)
      true

module.exports = Application
