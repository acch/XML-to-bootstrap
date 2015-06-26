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

    copy: {
      main: {
        files: [
          { nonull: true, src: path.join(bootstrap_path, 'less/variables.less'), dest: 'less/variables.less'},
          { nonull: true, expand: true, cwd: path.join(bootstrap_path, 'dist/css'), src: 'bootstrap*.min.css', dest: 'publish/css/'},
          { nonull: true, src: path.join(bootstrap_path, 'dist/js/bootstrap.min.js'), dest: 'publish/js/bootstrap.min.js'},
        ]
      }
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

    connect: {
      server: {
        options: {
          port: 8000,
          base: 'publish',
          keepalive: true,
          //open: 'http://localhost:8000/articles.html',
          debug: true
        }
      }
    }
  });

  // Load the plugin(s)
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-xsltproc');

  // Default task(s)
  grunt.registerTask('default', ['clean', 'copy', 'xsltproc', 'less', 'cssmin', 'connect']);
  // Everything except minification
  grunt.registerTask('debug', ['clean', 'copy', 'xsltproc', 'less', 'connect']);
};
