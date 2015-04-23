module.exports = function(grunt) {

  // Project configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      main: ["publish/*"]
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
    }
  });

  // Load the plugin(s)
  grunt.loadNpmTasks('grunt-xsltproc');
  grunt.loadNpmTasks('grunt-contrib-clean');

  // Default task(s)
  grunt.registerTask('default', ['clean', 'xsltproc']);
};
