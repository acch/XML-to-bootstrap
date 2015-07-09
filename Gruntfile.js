module.exports = function(grunt) {

  // Dependencies
  var path = require('path');

  // Variables
  var bootstrap_path = '../bootstrap';

  // Project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      main: ['publish/*', 'less/variables.less']
    },

    xsltproc: {
      options: {
        stylesheet: 'style/main.xsl',
        xinclude: true
      },
      main: {
        files: {
          'publish/index.html': 'src/main.xml'
        }
      }
    },

    copy: {
      main: {
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
          }
        ]
      }
    },

    less: {
      main: {
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
      main: {
        src: ['publish/css/style.css']
      }
    },

    csslint: {
      options: {
        'adjoining-classes': false,
        'compatible-vendor-prefixes': false
      },
      main: {
        src: ['publish/css/style.css']
      }
    },

    cssmin: {
      main: {
        files: {
          'publish/css/style.css': 'publish/css/style.css'
        }
      }
    },

    htmlmin: {
      main: {
        options: {
          removeComments: true,
          collapseWhitespace: true
        },
        expand: true,
        nonull: true,
        src: 'publish/*.html'
      }
    },

    connect: {
      server: {
        options: {
          port: 8000,
          base: 'publish',
          keepalive: true,
          //open: 'http://localhost:8000/articles.html',
        }
      }
    }
  });

  // Load the plugin(s)
  require('load-grunt-tasks')(grunt);

  // Copy sample files
  grunt.registerTask('copy_samples', function() {
    // Recurse samples directory
    grunt.file.recurse('src/sample', function(abspath, rootdir, subdir, filename) {
      var destfile = path.join('src', filename);
      // Check if destination file exists
      if (! grunt.file.exists(destfile)) {
        grunt.log.writeln('Copying sample: ' + filename);
        // Copy sample to destination
        grunt.file.copy(abspath, destfile);
      }
    });
  });

  // Read bootstrap config.json
  grunt.registerTask('parse_bootstrap_config', function() {
    var bootstrap_config = grunt.file.readJSON(path.join(bootstrap_path, 'config.json'));
    var variables = '';
    for (var key in bootstrap_config.vars) {
      variables += key + ':\t' + bootstrap_config.vars[key] + ';\n';
    }
    grunt.file.write('less/variables.less', variables);
  });

  // Default task including everything
  grunt.registerTask('default', ['clean', 'copy', 'copy_samples', 'xsltproc', 'parse_bootstrap_config', 'less', 'autoprefixer', 'csslint', 'cssmin', 'htmlmin', 'connect']);
  // Everything except minification
  grunt.registerTask('debug', ['clean', 'copy', 'copy_samples', 'xsltproc', 'parse_bootstrap_config', 'less', 'autoprefixer', 'csslint', 'connect']);
};
