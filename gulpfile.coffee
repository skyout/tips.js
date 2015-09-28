coffeelint              = require "gulp-coffeelint"
runSequence             = require "run-sequence"
jasmine                 = require "gulp-jasmine"
changed                 = require "gulp-changed"
stylus                  = require "gulp-stylus"
coffee                  = require "gulp-coffee"
concat                  = require "gulp-concat"
uglify                  = require "gulp-uglify"
Server                  = require("karma").Server
newer                   = require "gulp-newer"
shell                   = require "gulp-shell"
bump                    = require "gulp-bump"
nodeDev                 = require "node-dev"
lab                     = require "gulp-lab"
gulp                    = require "gulp"
browserify              = require "browserify"
buffer                  = require "vinyl-buffer"
source                  = require "vinyl-source-stream"
sourcemaps              = require "gulp-sourcemaps"


# CONFIGS
paths =
    scripts:        'public/coffee/**/*.coffee'
    images:         'public/img_src/**/*'
    stylus:         'public/stylus/**/*.styl'
    spec:           'spec/**/*.coffee'

# COMPILE AND CONVERT COFFEESCRIPT FILES
gulp.task "scripts", (err) ->
    return browserify
        entries: ["public/coffee/index.coffee"]
        extensions: [".coffee"]
        transform: "coffeeify"
    .bundle()
    .pipe source "tips.js"
    .pipe buffer()
    .pipe sourcemaps.init { loadMaps: true, debug: true }
    .pipe sourcemaps.write("./")
    .pipe gulp.dest "public/js"
    .on "error", (err) ->
        throw err


# UGLIFY JAVASCRIPT FILE
gulp.task 'uglify', ->
    return gulp.src 'public/js/tips.min.js'
        .pipe uglify()
        .pipe gulp.dest 'public/js'
        .on 'error', (err) ->
            throw err

# COFFEELINT
gulp.task 'lint', ->
    return gulp.src ['./public/coffee/**/*.coffee', './public/app/**/*.coffee', './spec/**/*.coffee']
        .pipe coffeelint()
        .pipe coffeelint.reporter()

# COMPILE AND CONVERT STYLUS FILES
gulp.task 'stylus', ->
    return gulp.src ['public/stylus/styles.styl', 'public/stylus/ie.styl']
        .pipe newer paths.stylus
        .pipe changed paths.stylus
        .pipe stylus({
            paths: ['public/css/']
            set: ['compress']
        })
        .pipe gulp.dest 'public/css'
        .on 'error', (err) ->
            throw err


# OPTIMIZE AND MOVE IMAGE SOURCE FILES
gulp.task 'images', ->
    return gulp.src paths.images
        .pipe newer paths.images
        .pipe changed paths.images
        # .pipe imagemin {optimizationLevel: 5}
        .pipe gulp.dest 'public/img'
        .on 'error', (err) ->
            throw err


# VERSION BUMP
gulp.task 'bump', ->
    return gulp.src ['./bower.json','./package.json']
        .pipe bump()
        .pipe gulp.dest './'


# RUN TEST SUITE
gulp.task 'test', (done) ->
    new Server
        configFile: "#{__dirname}/spec/karma.conf.js"
        action: 'run'
    , () ->
        done()
    .start()

# WATCH FOR CHANGES IN TEST SUITE SOURCE FILES
gulp.task 'testwatch', ->
    gulp.watch paths.spec, ['test']


# WATCH FOR CHANGES COFFEESCRIPT AND RERUN TEST SUITE
gulp.task 'testrunner', ->
    gulp.watch paths.scripts, ['test']


# WATCH FOR NODE CHANGES, THEN RESTART NODE SERVER
gulp.task 'node-dev', shell.task [
    'node-dev app/app.coffee'
]


# WATCH FOR SCRIPT, STYLUS AND IMAGE CHANGES, THEN RUN ASSOCIATED TASK
gulp.task 'watch', ->
    gulp.watch paths.scripts, ->
        runSequence ['scripts']
    gulp.watch paths.stylus, ['stylus']
    gulp.watch paths.images, ['images']


# DEFAULT TASK AND TASK BUNDLES
gulp.task 'default', (cb) ->
    runSequence ['scripts', 'stylus', 'images', 'lint', 'watch', 'testwatch'], 'node-dev', cb

gulp.task 'build', (cb) ->
    runSequence ['scripts', 'stylus', 'images'], 'uglify', cb