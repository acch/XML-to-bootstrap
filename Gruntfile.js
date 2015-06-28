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
//          { nonull: true, src: path.join(bootstrap_path, 'less/variables.less'), dest: 'less/variables.less' },
          {
            nonull: true,
            expand: true,
            cwd: path.join(bootstrap_path, 'css'),
            src: 'bootstrap*.min.css',
            dest: 'publish/css/'
          },
          {
            nonull: true,
            src: path.join(bootstrap_path, 'js/bootstrap.min.js'),
            dest: 'publish/js/bootstrap.min.js'
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
        files: [{
          expand: true,
          src: 'publish/*.html',
          dest: '.'
        }]
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
//  grunt.registerTask('default', ['clean', 'copy', 'xsltproc', 'less', 'cssmin', 'connect']);
  grunt.registerTask('default', ['clean', 'copy', 'xsltproc', 'parse_bootstrap_config', 'less', 'cssmin', 'htmlmin', 'connect']);
  // Everything except minification
  grunt.registerTask('debug', ['clean', 'copy', 'xsltproc', 'parse_bootstrap_config', 'less', 'connect']);
};
