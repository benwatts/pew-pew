module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    bower: {
      install: {
        options: {
          targetDir: './dist/js/lib'
        }
      }
    },

    sass: {
      dist: {
        options: {
          style: 'compressed'
        },
        files: {
          'dist/css/style.css': 'css/style.scss'
        }
      }
    },

    autoprefixer: {
      dist: {
        options: {
          browsers: "last 2 versions"
        },
        src:  'dist/css/style.css'
      }
    },

    coffee: {
      compile: {
        files: {
          'dist/js/script.js': ['js/*.coffee']
        }
      }
    },

    watch: {
      options: {
        livereload: true
      },
      html: {
        files: ['dist/game.html']
      },
      css: {
        files: ['css/*.scss'],
        tasks: ['sass', 'autoprefixer']
      },
      coffee: {
        files: ['js/*.coffee'],
        tasks: ['coffee']
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-bower-task');
  grunt.loadNpmTasks('grunt-autoprefixer');

  var devTasks = ['sass', 'coffee', 'watch'];
  grunt.registerTask('default', devTasks);
  grunt.registerTask('dev', devTasks);
  grunt.registerTask('build', ['bower:install', 'sass', 'autoprefixer', 'coffee']);

};
