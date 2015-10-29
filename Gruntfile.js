module.exports = function(grunt) {

  // dependencies
  var path = require('path');

  // variables
  var bootstrap_path = 'lib/bootstrap';
  var scrollposstyler_path = 'lib/scrollpos-styler';

  // project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      publish: ['publish/*', 'less/variables.less', 'js/options.json', 'js/scrollPosStyler.js']
    },

    xsltproc: {
      options: {
        stylesheet: 'style/main.xsl',
        xinclude: true
      },
      publish: {
        files: {
          'publish/index.html': 'src/main.xml'
        }
      }
    },

    bower: {
      install: {
        options: {
          cleanTargetDir: true,
          cleanBowerDir: false,
          layout: 'byComponent'
        }
      }
    },

    copy: {
      publish: {
        files: [
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: bootstrap_path,
            src: '**/bootstrap*.min.css',
            dest: 'publish/css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: bootstrap_path,
            src: '**/bootstrap.min.js',
            dest: 'publish/js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: bootstrap_path,
            src: '**/variables.less',
            dest: 'less/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: scrollposstyler_path,
            src: '**/scrollPosStyler.js',
            dest: 'js/'
          }
        ]
      }
    },

    concat: {
      publish: {
        src: ['js/options.json', 'js/*.js'],
        dest: 'publish/js/script.js',
      },
    },

    uglify: {
      publish: {
        files: {
          'publish/js/script.js': 'publish/js/script.js'
        }
      }
    },

    less: {
      publish: {
        options: {
          strictMath: true
        },
        files: {
          'publish/css/style.css': 'less/style.less'
        }
      }
    },

    autoprefixer: {
//      options: {
//        'browsers': '> 1%, last 2 versions'
//      },
      publish: {
        src: ['publish/css/style.css']
      }
    },

    csslint: {
      options: {
        'adjoining-classes': false,
        'compatible-vendor-prefixes': false
      },
      publish: {
        src: ['publish/css/style.css']
      }
    },

    cssmin: {
      publish: {
        files: {
          'publish/css/style.css': 'publish/css/style.css'
        }
      }
    },

    htmlmin: {
      publish: {
        options: {
          removeComments: true,
          collapseWhitespace: true
        },
        expand: true,
        nonull: true,
        src: 'publish/**/*.html'
      }
    },

    connect: {
      server: {
        options: {
          port: 8000,
          base: 'publish',
          keepalive: true,
          //open: 'http://localhost:8000/',
        }
      }
    }
  });

  // load the plugin(s)
  require('load-grunt-tasks')(grunt);

  // copy sample files
  grunt.registerTask('copy_samples', function() {
    // recurse samples directory
    grunt.file.recurse('src/sample', function(abspath, rootdir, subdir, filename) {
      var destfile = path.join('src', filename);

      // check if destination file exists
      if (! grunt.file.exists(destfile)) {
        grunt.log.writeln('Copying sample: ' + filename);

        // copy sample to destination
        grunt.file.copy(abspath, destfile);
      }
    });
  });

  // default task including everything
  grunt.registerTask('default', [
    'clean',
    'bower',
    'copy',
    'copy_samples',
    'xsltproc',
    'concat',
    'uglify',
    'less',
    'autoprefixer',
    'csslint',
    'cssmin',
    'htmlmin',
    'connect']);

  // everything except minification
  grunt.registerTask('debug', [
    'clean',
    'bower',
    'copy',
    'copy_samples',
    'xsltproc',
    'concat',
    'less',
    'autoprefixer',
    'csslint',
    'connect']);
};
