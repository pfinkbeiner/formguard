module.exports = (grunt) ->
  grunt.initConfig
    uglify:
      options:
        mangle: true
        compress: true
      target:
        src: "assets/js/FormGuard.js"
        dest: "assets/js/FormGuard.min.js"
    jshint:
      options:
        predef: ["jQuery"]
        shadow: true
        curly: false
        eqeqeq: false
        eqnull: true
        immed: false
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        boss: true,

      files: ['assets/js/FormGuard.js']

  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.registerTask 'test', ['jshint']
  grunt.registerTask 'build', ['jshint', 'uglify']
