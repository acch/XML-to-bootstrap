module.exports = function(grunt) {

  // Project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      main: ['publish/*']
    },
    xsltproc: {
      options: {
        stylesheet: 'styles/main.xsl',
        xinclude: true,
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
  grunt.loadNpmTasks('grunt-xsltproc');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-connect');

  // Default task(s)
  grunt.registerTask('default', ['clean', 'xsltproc', 'connect']);
};
