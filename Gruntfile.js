/* -------------------------------------------------------------------------- *\
   Gruntfile - project build instructions
   --------------------------------------------------------------------------

   This file is part of XML-to-bootstrap.
   https://github.com/acch/XML-to-bootstrap

   Copyright 2016 Achim Christ
   Released under the MIT license
   (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

\* -------------------------------------------------------------------------- */

module.exports = function(grunt) {
  "use strict";

  //TODO:
  //  - jshint task? (inkl. .jshintrc)
  //  - scsslint task?
  //  - uncss task?

  // dependencies
  var path = require('path');

  // path definitions
  var pathdef = {
    'bootstrap':       'modules/bootstrap/dist',
    'fontawesome':     'lib/font-awesome',
    'headroom':        'lib/headroom.js',
    'jquery':          'lib/jquery',
    'tether':          'lib/tether',
    'photoswipe':      'lib/photoswipe',
    'scrollposstyler': 'lib/scrollpos-styler',
    'anchor':          'lib/anchor-js'
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
        'js/scrollPosStyler.js',
        'js/anchor.js'
      ]
    },

    xsltproc: {
      options: {
        stylesheet: 'style/main.xsl',
        xinclude: true
      },
      dev: {
        files: {
          'publish/index.html': 'src/main.xml'
        },
        options: {
          params: {
            'devmode': 'true()'
          }
        }
      },
      prod: {
        files: {
          'publish/index.html': 'src/main.xml'
        },
        options: {
          params: {
            'devmode': 'false()'
          }
        }
      }
    },

    bower: {
      publish: {
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
            src: '**/bootstrap.min.css',
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
            cwd: pathdef.tether,
            src: '**/tether.min.js',
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
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: pathdef.anchor,
            src: '**/anchor.js',
            dest: 'js/'
          }
        ]
      },

      assets: {
        expand: true,
        cwd: 'img/min/',
        src: '**/*.{png,jpg,gif}',
        dest: 'publish/assets/'
      }
    },

    concat: {
      publish: {
        files: [
          {
            src: [
              'js/options.json',
              'js/headroom.js',
              'js/scrollPosStyler.js',
              'js/anchor.js',
              'js/headings.js',
              'js/navbar.js'
            ],
            dest: 'publish/js/script.js'
          },
          {
            src: 'css/*.css',
            dest: 'publish/css/gallery.css'
          },
          {
            src: 'js/photoswipe*.js',
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
      options: {
        style: 'nested'
      },
      publish: {
        files: {
          'publish/css/style.css': 'sass/style.scss'
        }
      }
    },

    autoprefixer: {
//      options: {
//        browsers: '> 1%, last 2 versions'
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
        'compatible-vendor-prefixes': false,
        'important': false
      },
      publish: {
        src: 'publish/css/style.css'
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

    htmllint: {
      options: {
        ignore: [
          'The "contentinfo" role is unnecessary for element "footer".',
          'The "banner" role is unnecessary for element "header".'
        ]
      },
      publish: 'publish/**/*.html'
    },

    htmlmin: {
      options: {
        removeComments: true,
        collapseWhitespace: true
      },
      publish: {
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

    responsive_images: {
      options: {
        concurrency: 2,
        sizes: [
          {
            name: '510',
            width: 510
          },
          {
            name: '730',
            width: 730
          }
        ]
      },
      assets: {
        expand: true,
        cwd: 'src/img/',
        src: '**/*.{png,jpg,gif}',
        dest: 'img/'
      }
    },

    imagemin: {
      assets: {
        expand: true,
        cwd: 'img/',
        src: [ '**/*.{png,jpg,gif}', '!min/**' ],
        dest: 'img/min/'
      }
    },

    connect: {
      publish: {
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

    // copy Sass samples
    copySampleIfNotExist('sass');

    // copy sample images only if directory doesn't exist, yet
    if (! grunt.file.isDir('src/img/')) {

      // copy sample images
      grunt.log.writeln('Copying sample images');
      grunt.file.copy('src/sampleimg/', 'src/img/');
    }
  });

  // no minification but linting (use this for development)
  grunt.registerTask('debug', [
    'clean',
    'bower',
    'copy:publish',
    'copy_samples',
    'xsltproc:dev',
    'concat',
    'sass',
    'autoprefixer',
    'csslint',
    'prettify',
    'htmllint',
    'responsive_images',
    'newer:imagemin',
    'copy:assets'
  ]);

  // no linting but minification (use this for development)
  grunt.registerTask('default', [
    'clean',
    'bower',
    'copy:publish',
    'copy_samples',
    'xsltproc:dev',
    'concat',
    'uglify',
    'sass',
    'autoprefixer',
    'cssmin',
    'htmlmin',
    'responsive_images',
    'newer:imagemin',
    'copy:assets'
  ]);

  // no linting but minification (use this for production)
  grunt.registerTask('prod', [
    'clean',
    'bower',
    'copy:publish',
    'copy_samples',
    'xsltproc:prod',
    'concat',
    'uglify',
    'sass',
    'autoprefixer',
    'cssmin',
    'htmlmin',
    'responsive_images',
    'newer:imagemin',
    'copy:assets'
  ]);

};
