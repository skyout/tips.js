del                 = require "del"
gulp                = require "gulp"
changed             = require "gulp-changed"
coffee              = require "gulp-coffee"
stylus              = require "gulp-stylus"
uglify              = require "gulp-uglify"
runSequence         = require "run-sequence"

# clean out generated files
gulp.task "clean", (err) ->
    return del ["dist/**/*", "demo/js/tips.js", "demo/css/**/*"]

# compile coffee
gulp.task "scripts", (err) ->

    return gulp.src ["src/coffee/*.coffee"]
        .pipe changed "src/coffee/*.coffee"
        .pipe coffee ({
            bare: true
            compile: true
        })
        .pipe uglify()
        .pipe gulp.dest "dist/js"
        .pipe gulp.dest "demo/js"
        .on "error", (err) ->
            throw err

# compile stylus
gulp.task "stylus", (err) ->

    # stylus for plugin
    gulp.src ["src/stylus/tips.styl"]
        .pipe changed "src/stylus/**.*.styl"
        .pipe stylus ({
            paths: ["dist/css/"]
            compress: true
        })
        .pipe gulp.dest "dist/css"
        .pipe gulp.dest "demo/css"
        .on "error", (err) ->
            throw err

    # stylus for demo
    return gulp.src ["demo/stylus/styles.styl"]
        .pipe changed "demo/stylus/**.*.styl"
        .pipe stylus ({
            paths: ["demo/css/"]
            compress: true
        })
        .pipe gulp.dest "demo/css"
        .on "error", (err) ->
            throw err

# watch for changes
gulp.task "watch", ->
    gulp.watch ["src/stylus/**/*.styl","demo/stylus/**/*.styl"], ["stylus"]
    return gulp.watch "src/coffee/**/*.coffee", ["scripts"]

# default gulp task
gulp.task "default", (cb) ->

    return runSequence "clean", ["stylus", "scripts", "watch"], cb

# gulp build task
gulp.task "build", (cb) ->

    return runSequence "clean", ["stylus", "scripts"], cb