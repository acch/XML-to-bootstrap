module.exports = function(grunt) {

  // Includes
  var path = require('path');

  // Variables
  var bootstrap_path = '../bootstrap';

  // Project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      main: ['publish/*']
    },
    copy: {
      main: {
        nonull: true,
        src: path.join(bootstrap_path, 'less/variables.less'),
        dest: 'less/variables.less'
      }
    },
    xsltproc: {
      options: {
        stylesheet: 'styles/main.xsl',
        xinclude: true
      },
      main: {
        files: {
          'publish/index.html': ['src/main.xml']
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
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-xsltproc');

  // Default task(s)
  grunt.registerTask('default', ['clean', 'copy', 'xsltproc', 'connect']);
};
