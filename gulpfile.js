var gulp = require('gulp'),
    coffee = require('gulp-coffee');

gulp.task('scripts', function() {
    // Minify and copy all JavaScript (except vendor scripts)
    return gulp.src('./src/favbot.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('./'));
});

// Rerun the task when a file changes
gulp.task('watch', function () {
    gulp.watch('./src/favbot.coffee', ['scripts']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['scripts', 'watch']);
