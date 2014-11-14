del = require 'del'
browserify = require 'browserify'
bowerFiles = require 'main-bower-files'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
merge = require 'merge-stream'

gulp = require 'gulp'
gutil = require 'gulp-util'
autoprefixer = require 'gulp-autoprefixer'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
sass = require 'gulp-sass'
uglify = require 'gulp-uglify'

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
    src: "#{src}/styles/**/*.sass"
    dest: "#{dest}/css"
    name: 'app.css'
  scripts:
    src: "#{src}/scripts/**/*.{coffee,cjsx}"
    dest: "#{dest}/js"
    name: 'app.js'

bundler = browserify "#{src}/scripts/app.coffee",
  debug: false
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

gulp.task 'styles', ->
  gulp.src config.styles.src
    .pipe sass style: 'expanded', sourceComments: 'normal'
    .on 'error', handleError 'sass'
    .pipe autoprefixer 'last 2 versions'
    .pipe concat config.styles.name
    .pipe onProduction minifyCss
    .pipe gulp.dest config.styles.dest

gulp.task 'scripts', ->
  libs = gulp.src bowerFiles filter: /\.js$/

  ours = bundler
    .bundle()
    .on 'error', handleError 'browserify'
    .pipe source 'ours.js'

  merge libs, ours
    .pipe buffer()
    .pipe concat config.scripts.name
    .pipe onProduction uglify
    .pipe gulp.dest config.scripts.dest

gulp.task 'clean', (cb) ->
  del dest, cb

gulp.task 'watch', ->
  gulp.watch config.images.src, ['images']
  gulp.watch config.styles.src, ['styles']
  gulp.watch config.scripts.src, ['scripts']

gulp.task 'default', ['clean'], ->
  gulp.start ['fonts', 'images', 'styles', 'scripts']
