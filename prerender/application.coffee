# _ = require 'lodash'
# fs = require 'fs'
# typesMap = require '../frontend/scripts/helpers/marty/types_map'
# AbstractApplication = require '../frontend/scripts/abstract_application'
#
# class Application extends AbstractApplication
#   constructor: (options) ->
#     super options
#
#     ['actions', 'queries', 'sources', 'stores'].each (dir) =>
#       files = fs.readdirSync "./frontend/scripts/#{dir}"
#       files.each (file) =>
#         type = typesMap[dir] || dir
#         name = file.split('.')[0]
#         fullname = "#{name}_#{type}"
#         object = require "../frontend/scripts/#{dir}/#{name}"
#         @register _.camelCase(fullname), object
#
# module.exports = Application
