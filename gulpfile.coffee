gulp = require 'gulp'
gutil = require 'gulp-util'
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'
autoprefixer = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
livereload = require 'gulp-livereload'
rimraf = require 'rimraf'
list = require 'gulp-task-listing'

dest = './static_generated'

gulp.task 'default', [ 'watch' ]

gulp.task 'help', list

gulp.task 'clean', ( cb ) ->
  rimraf dest, cb
  return null

gulp.task 'sass', ->
  gulp.src './src/sass/**/*.sass'
    .pipe sourcemaps.init()
    .pipe sass(
        outputStyle: 'expanded'
        includePaths: [ './bower_components/' ]
      ).on 'error', sass.logError
    .pipe autoprefixer ['> 1%']
    .pipe sourcemaps.write '../map' # , sourceRoot: __dirname + './src'
    .pipe gulp.dest dest + '/css'
    .pipe livereload()
  return null

gulp.task 'copyjs', ->
  gulp.src './bower_components/jquery/dist/*'
    .pipe gulp.dest dest + '/js/jquery'
  gulp.src './bower_components/bootstrap/js/dist/*'
    .pipe gulp.dest dest + '/js/bootstrap'
  return null

gulp.task 'copycss', ->
  return null

gulp.task 'copyfont', ->
  gulp.src './bower_components/font-awesome/fonts/*'
    .pipe gulp.dest dest + '/fonts'
  return null

gulp.task 'coffee', ->
  gulp.src './src/coffee/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe coffee(
        bare: true
      ).on 'error', gutil.log
    .pipe sourcemaps.write '../map' # , sourceRoot: __dirname + './src'
    .pipe gulp.dest dest + '/js'
    .pipe livereload()
  return null

gulp.task 'reload', ->
  livereload.reload()
  return null

gulp.task 'watch', [ 'copystatic', 'copyfont', 'copycss', 'sass', 'copyjs', 'coffee' ], ->
  gulp.watch './static/**/*.*', ['reload']
  gulp.watch './src/sass/**/*.sass', ['sass']
  gulp.watch './src/coffee/**/*.coffee', ['coffee']
  gulp.watch './views/**/*.jade', ['jade']
  gulp.watch './view-data/**/*.coffee', ['jade']
  gulp.watch './readme.md', ['jade']
  livereload.listen
    basePath: './src'
    start: true
  return null

# static site stuff
jade = require 'gulp-jade'
fs = require 'fs'
coffeeScript = require 'coffee-script'

_jadeData = {}
gulp.task 'setupJadeData', ( next ) ->
  fs.readFile './view-data/global.coffee', 'utf8', ( err, _data ) ->
    if err
      throw err
    else
      coffeeopts =
        bare: true
        header: false
      _jadeData = eval coffeeScript.compile _data, coffeeopts
    next()
  return null

gulp.task 'jade', [ 'setupJadeData' ], ->
  gulp.src [ './views/**/*.jade', '!./views/layout/**' ]
    .pipe jade
      locals: _jadeData
      pretty: true
    .pipe gulp.dest dest
    .pipe livereload()
  return null

gulp.task 'copystatic', ->
  gulp.src [ './static/**', dest + '/**' ]
    .pipe gulp.dest dest
  return null

gulp.task 'render', [ 'copystatic', 'jade', 'copyfont', 'copycss', 'sass', 'copyjs', 'coffee' ], ( cb ) ->
  rimraf dest + '/map', cb
  return null

gulp.task 'build', [ 'clean' ], ->
  gulp.start 'render'
  return null
