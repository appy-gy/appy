fs = require 'fs'
path = require 'path'

_ = require 'lodash'
del = require 'del'
browserify = require 'browserify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
notifier = require 'node-notifier'

gulp = require 'gulp'
gutil = require 'gulp-util'
autoprefixer = require 'gulp-autoprefixer'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
sass = require 'gulp-ruby-sass'
uglify = require 'gulp-uglify'

{colors} = gutil

env = process.env.NODE_ENV

src = './frontend'
dest = './public/assets'

config =
  images:
    src: "#{src}/images/**/*"
    dest: "#{dest}/images"
  styles:
    src: "#{src}/styles/app.sass"
    srcs: "#{src}/styles/**/*.sass"
    dest: "#{dest}/css"
    name: 'app.css'
  scripts:
    folder: "#{src}/scripts"
    src: "#{src}/scripts/app.coffee"
    srcs: "#{src}/scripts/**/*.{coffee,cjsx}"
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
    @emit 'end'

gulp.task 'images', ->
  gulp.src config.images.src
    .pipe gulp.dest config.images.dest

gulp.task 'styles', ->
  sass config.styles.src, style: 'expanded'
    .on 'error', handleError 'sass'
    .pipe autoprefixer browsers: ['last 2 versions']
    .pipe onProduction minifyCss
    .pipe gulp.dest config.styles.dest

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
  gulp.watch path.normalize(config.images.src), ['images']
  gulp.watch path.normalize(config.styles.srcs), ['styles']

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
      gutil.log "Finished '#{colors.cyan 'watchify'}' after #{colors.magenta "#{time} ms"}"

  watcher.bundle()

gulp.task 'default', ['clean'], ->
  gulp.start ['images', 'styles', 'scripts']
