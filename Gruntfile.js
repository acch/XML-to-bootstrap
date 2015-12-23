module.exports = function(grunt) {
  "use strict";

  // dependencies
  var path = require('path');

  // variables
  var bootstrap_path = 'lib/bootstrap';
  var scrollposstyler_path = 'lib/scrollpos-styler';
  var photoswipe_path = 'lib/photoswipe';

  // project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      publish: ['publish/*', 'css/*', 'js/options.json', 'js/scrollPosStyler.js', 'js/photoswipe*.js']
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
            cwd: scrollposstyler_path,
            src: '**/scrollPosStyler.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: photoswipe_path,
            src: ['**/photoswipe.css', '**/default-skin.css'],
            dest: 'css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: photoswipe_path,
            src: '**/photoswipe*.js',
            dest: 'js/'
          }
        ]
      }
    },

    concat: {
      publish: {
        files: [
          {
            src: ['js/options.json', 'js/navbar.js', 'js/scrollPosStyler.js'],
            dest: 'publish/js/script.js'
          },
          {
            src: ['css/*.css'],
            dest: 'publish/css/gallery.css'
          },
          {
            src: ['js/photoswipe*.js'],
            dest: 'publish/js/gallery.js'
          }
        ]
      }
    },

    uglify: {
      publish: {
        files: {
          'publish/js/script.js': 'publish/js/script.js',
          'publish/js/gallery.js': 'publish/js/gallery.js'
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
        files: {
          'publish/css/style.css': 'publish/css/style.css',
          'publish/css/gallery.css': 'publish/css/gallery.css'
        }
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
          'publish/css/style.css': 'publish/css/style.css',
          'publish/css/gallery.css': 'publish/css/gallery.css'
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

  // copy bootstrap variables
  grunt.registerTask('copy_variables', function() {
    // check if variables.less already exists
    if (grunt.file.exists('less/variables.less')) {
      // nothing to do
      return true;
    }

    // find variables.less in bootstrap_path
    var bootstrap_config_path = grunt.file.expand({ cwd: bootstrap_path }, '**/variables.less')[0];
    if (! bootstrap_config_path) {
      // variables.less not found
      return false;
    }

    grunt.log.writeln('Copying Bootstrap variables: ' + bootstrap_config_path);

    // Copy variables.less
    grunt.file.copy(path.join(bootstrap_path, bootstrap_config_path), 'less/variables.less');
  });

  // default task including everything
  grunt.registerTask('default', [
    'clean',
    'bower',
    'copy',
    'copy_samples',
    'copy_variables',
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
    'copy_variables',
    'xsltproc',
    'concat',
    'less',
    'autoprefixer',
    'csslint',
    'connect']);
};
