var gulp = require("gulp");
var shell = require("gulp-shell");

var params = process.argv[4];
gulp.task('push', shell.task([
  'gulp',
  'git add -A',
  'git commit -am ' + JSON.stringify(params),
  'git push origin master'
]));

gulp.task('default', function() {});
