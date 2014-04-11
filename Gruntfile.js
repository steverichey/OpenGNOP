/*global module*/

module.exports = function(grunt) {
	grunt.loadNpmTasks('grunt-concat-sourcemap');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-clean');
	
	var srcFiles = [
		'<%= dirs.src %>/OS7.js',
		'<%= dirs.src %>/Main.js',
		'<%= dirs.src %>/Text.js',
		'<%= dirs.src %>/Time.js',
		'<%= dirs.src %>/Desktop.js',
		'<%= dirs.src %>/Window.js',
		'<%= dirs.src %>/Settings.js',
		'<%= dirs.src %>/Icon.js',
		'<%= dirs.src %>/Colors.js',
		'<%= dirs.src %>/Checkbox.js'
	];
	
	var banner = [
		'/**',
		' * <%= pkg.name %> - v<%= pkg.version %>',
		' * <%= pkg.copyright %>, <%= pkg.author %>',
		' *',
		' * Compiled: <%= grunt.template.today("yyyy-mm-dd") %>',
		' *',
		' * <%= pkg.name %> is licensed under the <%= pkg.license %> License.',
		' * <%= pkg.licenseUrl %>',
		' */'
	].join('\n');
	
	var assets = 'assets';
	
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		dirs: {
			build: 'bin',
			src: 'src/OS7'
		},
		files: {
			build: '<%= dirs.build %>/openos7.js',
			buildMin: '<%= dirs.build %>/openos7.min.js'
		},
		concat: {
			options: {
				banner: banner
			},
			dist: {
				src: srcFiles,
				dest: '<%= files.build %>'
			}
        },
		concat_sourcemap: {
            dev: {
                files: {
                    '<%= files.build %>': srcFiles
                },
                options: {
                    sourceRoot: '../'
                }
            }
        },
		uglify: {
            options: {
                banner: banner
            },
            dist: {
                src: '<%= files.build %>',
                dest: '<%= files.buildMin %>'
            }
        },
		copy: {
			main: {
				files: [
					{expand: true, src: [assets+'/images/*'], dest: '<%= dirs.build %>/'},
					{expand: true, src: [assets+'/sounds/*'], dest: '<%= dirs.build %>/'},
					{expand: true, flatten: true, src: ['src/index.html'], dest: '<%= dirs.build %>/'},
					{expand: true, flatten: true, src: ['libs/pixi/pixi.dev.js'], dest: '<%= dirs.build %>/'},
					{expand: true, flatten: true, src: ['src/Gnop.js'], dest: '<%= dirs.build %>/'}
				]
			}
		},
		clean: ['bin']
	});
	
	// Default task(s).
	grunt.registerTask('build', ['concat', 'copy']);
	grunt.registerTask('build-release', ['concat', 'uglify', 'copy']);
	grunt.registerTask('clean', ['clean'])
};