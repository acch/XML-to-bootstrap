module.exports = function(grunt) {
  "use strict";

  //TODO:
  //  - htmllint task
  //  - scsslint task
  //  - postcss autoprefixer insead of autoprefixer?

  // dependencies
  var path = require('path');

  // path definitions
  var pathdef = {
    'bootstrap':       'modules/bootstrap/dist',
    'fontawesome':     'lib/font-awesome',
    'headroom':        'lib/headroom.js',
    'jquery':          'lib/jquery',
    'photoswipe':      'lib/photoswipe',
    'scrollposstyler': 'lib/scrollpos-styler'
  };

  // project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      publish: [
        'publish/*',
        'css/*',
        'js/options.json',
        'js/headroom.js',
        'js/photoswipe*.js',
        'js/scrollPosStyler.js'
      ]
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
            cwd: pathdef.bootstrap,
            src: '**/bootstrap*.min.css',
            dest: 'publish/css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.bootstrap,
            src: '**/bootstrap.min.js',
            dest: 'publish/js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.fontawesome,
            src: '**/font-awesome.min.css',
            dest: 'publish/css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.headroom,
            src: '**/headroom.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.jquery,
            src: '**/jquery.min.js',
            dest: 'publish/js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.photoswipe,
            src: ['**/photoswipe.css', '**/default-skin.css'],
            dest: 'css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.photoswipe,
            src: '**/photoswipe*.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.scrollposstyler,
            src: '**/scrollPosStyler.js',
            dest: 'js/'
          }
        ]
      }
    },

    concat: {
      publish: {
        files: [
          {
            src: ['js/options.json', 'js/headroom.js', 'js/navbar.js', 'js/scrollPosStyler.js'],
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

    sass: {
      publish: {
        options: {
          style: 'nested'
        },
        files: {
          'publish/css/style.css': 'sass/style.scss'
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

    prettify: {
      publish: {
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

    // copy sample files if they don't exist
    function copySampleIfNotExist(relpath) {

      // recurse sample subdirectory
      grunt.file.recurse(path.join(relpath, 'sample'), function(abspath, rootdir, subdir, filename) {

        // check if destination file exists
        var destfile = path.join(relpath, filename);
        if (! grunt.file.exists(destfile)) {

          // copy sample to destination
          grunt.log.writeln('Copying sample: ' + filename);
          grunt.file.copy(abspath, destfile);
        }
      });
    }

    // copy XML samples
    copySampleIfNotExist('src');

    // copy sass samples
    copySampleIfNotExist('sass');
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
    'sass',
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
    'sass',
    'autoprefixer',
    'csslint',
    'prettify',
    'connect']);
};
