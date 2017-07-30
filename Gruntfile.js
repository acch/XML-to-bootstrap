/* -------------------------------------------------------------------------- *\
   Gruntfile - project build instructions
   --------------------------------------------------------------------------

   This file is part of XML-to-bootstrap.
   https://github.com/acch/XML-to-bootstrap

   Copyright 2016 Achim Christ
   Released under the MIT license
   (https://github.com/acch/XML-to-bootstrap/blob/master/LICENSE)

\* -------------------------------------------------------------------------- */

// TODO: uncss task?
// TODO: jshint task? (inkl. .jshintrc)
// TODO: scsslint task?

module.exports = function(grunt) {
  "use strict";

  // dependencies
  var path = require('path');
  var parser = require('xml2json');

  // project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    // path definitions
    path: {
      anchor:          'lib/anchor-js',
      bootstrap:       'modules/bootstrap',
      fontawesome:     'lib/font-awesome',
      headroom:        'lib/headroom.js',
      jquery:          'lib/jquery',
      photoswipe:      'lib/photoswipe',
      scrollposstyler: 'lib/scrollpos-styler',
      tether:          'lib/tether'
    },

    exec: {
      submodules: {
        cmd: 'git submodule update --init \
        && if ! grep -q customvars <%= path.bootstrap %>/scss/_custom.scss; then echo \'@import "customvars";\' >> <%= path.bootstrap %>/scss/_custom.scss; fi \
        && ln -sf ../../../sass/customvars.scss <%= path.bootstrap %>/scss/'
      }
    },

    subgrunt: {
      bootstrap: {
        'modules/bootstrap': 'dist'
      }
    },

    clean: {
      publish: [
        'css/*',
        'js/*',
        '!js/headings.js',
        '!js/navbar.js',
        'publish/*'
      ]
    },

    bower: {
      publish: {
        options: {
          cleanBowerDir: false,
          cleanTargetDir: true,
          copy: true,
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
            cwd: '<%= path.anchor %>',
            src: '**/anchor.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.bootstrap %>/dist',
            src: '**/bootstrap.min.css',
            dest: 'publish/css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.bootstrap %>/dist',
            src: '**/bootstrap.min.js',
            dest: 'publish/js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.fontawesome %>',
            src: '**/font-awesome.min.css',
            dest: 'publish/css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.headroom %>',
            src: '**/headroom.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.jquery %>',
            src: '**/jquery.min.js',
            dest: 'publish/js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.photoswipe %>',
            src: ['**/photoswipe.css', '**/default-skin.css'],
            dest: 'css/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.photoswipe %>',
            src: '**/photoswipe*.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.scrollposstyler %>',
            src: '**/scrollPosStyler.js',
            dest: 'js/'
          },
          {
            expand: true,
            flatten: true,
            nonull: true,
            cwd: '<%= path.tether %>',
            src: '**/tether.min.js',
            dest: 'publish/js/'
          }
        ]
      },

      assets_pre: {
        expand: true,
        cwd: 'src/img/',
        src: '*.{png,jpg,gif}',
        dest: 'img/'
      },

      assets_post: {
        expand: true,
        cwd: 'img/min/',
        src: '**/*.{png,jpg,gif}',
        dest: 'publish/assets/'
      }
    },

    xsltproc: {
      options: {
        stylesheet: 'style/main.xsl',
        xinclude: true
      },
      dev: {
        options: {
          params: {
            'devmode': 'true()'
          }
        },
        src: 'src/main.xml',
        dest: 'publish/index.html'
      },
      prod: {
        options: {
          params: {
            'devmode': 'false()'
          }
        },
        src: '<%= xsltproc.dev.src %>',
        dest: '<%= xsltproc.dev.dest %>'
      }
    },

    concat: {
      publish: {
        files: [
          {
            src: [
              'js/options.json',
              'js/anchor.js',
              'js/headroom.js',
              'js/scrollPosStyler.js',
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
        src: 'sass/style.scss',
        dest: 'publish/css/style.css'
      }
    },

    autoprefixer: {
//      options: {
//        browsers: '> 1%, last 2 versions'
//      },
      publish: {
        src: ['publish/css/style.css', 'publish/css/gallery.css']
      }
    },

    csslint: {
      options: {
        'adjoining-classes': false,
        'compatible-vendor-prefixes': false,
        'fallback-colors': false,
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
      publish: {
        expand: true,
        nonull: true,
        src: 'publish/**/*.html'
      }
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
        concurrency: 2
        // sizes are defined by 'xmlopts' task
      },
      assets: {
        expand: true,
        cwd: 'src/img/',
        src: '*/**/*.{png,jpg,gif}',
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

  // read options from XML
  grunt.registerTask('xmlopts', function() {

    // parse options.xml as object
    var xmlopts = parser.toJson(grunt.file.read('src/options.xml'), {
      coerce: true,
      object: true
    }).options;

    // extract Grunt options
    var gruntopts = xmlopts.export.filter(function(e) {
      return e.type == 'grunt';
    })[0].option;

    // temp configuration object
    var config = {
      responsive_images: {
        options: {
          sizes: []
        }
      }
    };

    // iterate over Grunt options
    for (var i = 0; gruntopts[i]; ++i) {
      // add options to temp configuration object
      switch (gruntopts[i].name) {

        case 'responive_image.size':
          config.responsive_images.options.sizes.push({
            name: gruntopts[i]['$t'],
            width: gruntopts[i]['$t']
          });
          break;

        // ...process further options...

      }
    }

    // apply temp Grunt configuration
    grunt.config.merge(config);
  });

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

  // initialize submodules
  grunt.registerTask('init', [
    'copy_samples',
    'exec:submodules',
    'subgrunt'
  ]);

  // no minification but linting (use this for development)
  grunt.registerTask('debug', [
    'copy_samples',
    'xmlopts',
    'clean',
    'bower',
    'copy:publish',
    'xsltproc:dev',
    'concat',
    'sass',
    'autoprefixer',
    'csslint',
    'prettify',
    'htmllint',
    'copy:assets_pre',
    'responsive_images',
    'newer:imagemin',
    'copy:assets_post'
  ]);

  // no linting but minification (use this for development)
  grunt.registerTask('default', [
    'copy_samples',
    'xmlopts',
    'clean',
    'bower',
    'copy:publish',
    'xsltproc:dev',
    'concat',
    'uglify',
    'sass',
    'autoprefixer',
    'cssmin',
    'htmlmin',
    'copy:assets_pre',
    'responsive_images',
    'newer:imagemin',
    'copy:assets_post'
  ]);

  // no linting but minification (use this for production)
  grunt.registerTask('prod', [
    'copy_samples',
    'xmlopts',
    'clean',
    'bower',
    'copy:publish',
    'xsltproc:prod',
    'concat',
    'uglify',
    'sass',
    'autoprefixer',
    'cssmin',
    'htmlmin',
    'copy:assets_pre',
    'responsive_images',
    'imagemin',
    'copy:assets_post'
  ]);

};
