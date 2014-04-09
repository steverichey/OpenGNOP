/*global module*/

module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		concat: {
			options: {
				separator: ';'
			},
			dist: {
				src: [
					'src/OpenOS7/Header.js',
					'src/OpenOS7/OpenOS7.js',
					'src/OpenOS7/Main.js',
					'src/OpenOS7/Desktop.js',
					'src/OpenOS7/Window.js',
					'src/OpenOS7/Text.js',
					'src/OpenOS7/Time.js',
					'src/OpenOS7/Checkbox.js',
					'src/OpenOS7/Settings.js',
					'src/OpenOS7/Icon.js',
					'src/OpenOS7/Colors.js',
					'src/OpenOS7/Footer.js'
				],
				dest: 'bin/<%= pkg.name %>.js'
			}
		},
		uglify: {
			options: {
				banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
			},
			dist: {
				files: {
					'bin/<%= pkg.name %>.min.js': ['<%= concat.dist.dest %>']
				}
			}
		}
	});
	
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-qunit');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-concat');
	
	grunt.registerTask('default', ['concat', 'uglify']);
};