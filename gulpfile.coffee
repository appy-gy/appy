fs = require 'fs'
path = require 'path'

_ = require 'lodash'
_.str = require 'underscore.string'
del = require 'del'
browserify = require 'browserify'
watchify = require 'watchify'
bowerFiles = require 'main-bower-files'
source = require 'vinyl-source-stream'
path = require 'path'
notifier = require 'node-notifier'

gulp = require 'gulp'
gutil = require 'gulp-util'
autoprefixer = require 'gulp-autoprefixer'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
sass = require 'gulp-sass'
uglify = require 'gulp-uglify'

{colors} = gutil

{argv} = require('yargs').default(env: 'development')
{env} = argv

src = './frontend'
dest = './public/assets'

config =
  fonts:
    dest: "#{dest}/fonts"
  images:
    src: "#{src}/images/**/*"
    dest: "#{dest}/images"
  styles:
    src: "#{src}/styles/**/app.sass"
    srcs: "#{src}/styles/**/*.sass"
    vendor: "#{src}/styles/vendor"
    dest: "#{dest}/css"
    name: 'app.css'
  scripts:
    folder: "#{src}/scripts"
    src: "#{src}/scripts/app.coffee"
    srcs: "#{src}/scripts/**/*.{coffee,cjsx}"
    components: "#{src}/scripts/components/**/*.cjsx"
    componentsPath: "#{src}/scripts/components"
    stores: "#{src}/scripts/stores/**/*.coffee"
    storesPath: "#{src}/scripts/stores"
    dest: "#{dest}/js"
    name: 'app.js'
  browserify:
    entries: "#{src}/scripts/app.coffee"
    debug: env != 'production'
    extensions: ['.cjsx', '.coffee']

onEnv = (name, plugin) ->
  if env == name then plugin() else gutil.noop()

onDevelopment = (plugin) ->
  onEnv 'development', plugin

onProduction = (plugin) ->
  onEnv 'production', plugin

handleError = (plugin) ->
  (error) ->
    console.log error
    notifier.notify
      title: "#{plugin} error"
      message: error
      icon: path.join(__dirname, 'gulp-error.png')
    @emit 'end'

writeList = (listName, ext) ->
  root = config.scripts["#{listName}Path"]
  list = "#{listName} =\n"

  writeListForDir = (dir, level) ->
    indent = _.str.repeat '  ', level
    content = fs.readdirSync dir
    content.forEach (name) ->
      fullpath = path.join dir, name
      stat = fs.statSync fullpath
      if stat.isFile()
        basename = path.basename name, ext
        requirePath = "./#{listName}" + _.str.strRight path.join(dir, basename), root.replace(/\.\//, '')
        list += "#{indent}#{_.str.classify basename}: require '#{requirePath}'\n"
      else
        list += "#{indent}#{_.str.classify name}:\n"
        writeListForDir fullpath, level + 1

  writeListForDir root, 1
  list += "\nmodule.exports = #{listName}"

  fs.writeFileSync path.join(config.scripts.folder, "#{listName}.coffee"), list, flag: 'w'

gulp.task 'fonts', ->
  gulp.src bowerFiles filter: /\.(eot|svg|ttf|woff)$/
    .pipe gulp.dest config.fonts.dest

gulp.task 'images', ->
  gulp.src config.images.src
    .pipe gulp.dest config.images.dest

gulp.task 'moveBowerDeps', ->
  gulp.src bowerFiles filter: /\.css$/
    .pipe rename extname: '.scss'
    .pipe gulp.dest config.styles.vendor

gulp.task 'styles', ['moveBowerDeps'], ->
  gulp.src config.styles.src
    .pipe sass style: 'expanded', sourceComments: 'normal'
    .on 'error', handleError 'sass'
    .pipe autoprefixer 'last 2 versions'
    .pipe onProduction minifyCss
    .pipe gulp.dest config.styles.dest

gulp.task 'componentsList', ->
  writeList 'components', '.cjsx'

gulp.task 'storesList', ->
  writeList 'stores', '.coffee'

gulp.task 'scripts', ->
  bundler = browserify config.scripts.src, config.browserify

  bundler
    .bundle()
    .on 'error', handleError 'browserify'
    .pipe source config.scripts.name
    .pipe onProduction uglify
    .pipe gulp.dest config.scripts.dest

gulp.task 'clean', (cb) ->
  del dest, cb

gulp.task 'watch', ->
  gulp.watch config.images.src, ['images']
  gulp.watch config.styles.srcs, ['styles']
  gulp.watch config.scripts.components, ['componentsList']
  gulp.watch config.scripts.stores, ['storesList']

  bundler = browserify _.merge {}, config.browserify, watchify.args
  watcher = watchify bundler

  watcher
    .on 'update', ->
      watcher
        .bundle()
        .on 'error', handleError 'watchify'
        .pipe source config.scripts.name
        .pipe gulp.dest config.scripts.dest
    .on 'time', (time) ->
      notifier.notify
        title: 'Watchify'
        message: "Build finished in #{time} ms"
        icon: path.join(__dirname, 'gulp-success.png')
      gutil.log "Finished '#{colors.cyan 'watchify'}' after #{colors.magenta "#{time} ms"}"

  watcher.bundle()

gulp.task 'default', ['clean'], ->
  gulp.start ['fonts', 'images', 'styles', 'componentsList', 'storesList', 'scripts']
