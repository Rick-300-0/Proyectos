var gulp = require('gulp'),
    connect = require('gulp-connect-php'),
    browserSync = require('browser-sync');
 
gulp.task('default', function() {
  connect.server({}, function (){
    browserSync({
      server: {
        baseDir: './'
      }
      
    });
  });
  gulp.watch('./*.html').on('change', browserSync.reload),
  gulp.watch('./*.css').on('change', browserSync.reload),
  gulp.watch('./*.js').on('change', browserSync.reload),
  gulp.watch('./*.php').on('change', function () {browserSync.reload()});
});