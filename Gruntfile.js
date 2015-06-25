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
      variables: {
        nonull: true,
        src: path.join(bootstrap_path, 'less/variables.less'),
        dest: 'less/variables.less'
      },
      bootstrap_css: {
        expand: true,
        nonull: true,
        cwd: path.join(bootstrap_path, 'dist/css'),
        src: 'bootstrap*.min.css',
        dest: 'publish/css/'
      },
      bootstrap_js: {
        nonull: true,
        src: path.join(bootstrap_path, 'dist/js/bootstrap.min.js'),
        dest: 'publish/js/bootstrap.min.js'
      }
    },
    xsltproc: {
      options: {
        stylesheet: 'style/main.xsl',
        xinclude: true
      },
      main: {
        files: {
          'publish/index.html': ['src/main.xml']
        }
      }
    },
    less: {
      main: {
        src: 'less/style.less',
        dest: 'publish/css/style.css'
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
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-xsltproc');

  // Default task(s)
  grunt.registerTask('default', ['clean', 'copy', 'xsltproc', 'less', 'connect']);
};
