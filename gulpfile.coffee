_ = require 'lodash'
del = require 'del'
browserify = require 'browserify'
watchify = require 'watchify'
bowerFiles = require 'main-bower-files'
source = require 'vinyl-source-stream'

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
    src: "#{src}/scripts/app.coffee"
    srcs: "#{src}/scripts/**/*.{coffee,cjsx}"
    dest: "#{dest}/js"
    name: 'app.js'
  browserify:
    debug: true
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
    @emit 'end'

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
  gulp.src bowerFiles filter: /\.css$/
    .pipe rename extname: '.scss'
    .pipe gulp.dest config.styles.vendor

  gulp.src config.styles.src
    .pipe sass style: 'expanded', sourceComments: 'normal'
    .on 'error', handleError 'sass'
    .pipe autoprefixer 'last 2 versions'
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
  gulp.watch config.images.src, ['images']
  gulp.watch config.styles.srcs, ['styles']

  bundler = browserify config.scripts.src, _.merge(config.browserify, watchify.args)
  watcher = watchify bundler

  watcher
    .on 'update', ->
      watcher
        .bundle()
        .on 'error', handleError 'watchify'
        .pipe source config.scripts.name
        .pipe gulp.dest config.scripts.dest
    .on 'time', (time) ->
      gutil.log "Finished '#{colors.cyan 'watchify'}' after #{colors.magenta "#{time} ms"}"

gulp.task 'default', ['clean'], ->
  gulp.start ['fonts', 'images', 'styles', 'scripts']
