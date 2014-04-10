/*global module*/

module.exports = function(grunt) {
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	
	var srcFiles = [
		'<%= dirs.src %>/Header.js',
		'<%= dirs.src %>/OpenOS7.js',
		'<%= dirs.src %>/Main.js',
		'<%= dirs.src %>/Desktop.js',
		'<%= dirs.src %>/Window.js',
		'<%= dirs.src %>/Text.js',
		'<%= dirs.src %>/Time.js',
		'<%= dirs.src %>/Icon.js',
		'<%= dirs.src %>/Settings.js',
		'<%= dirs.src %>/Colors.js',
		'<%= dirs.src %>/Checkbox.js',
		'<%= dirs.src %>/Footer.js',
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
		uglify: {
            options: {
                banner: banner
            },
            dist: {
                src: '<%= files.build %>',
                dest: '<%= files.buildMin %>'
            }
        }
	});
	
	// Default task(s).
	grunt.registerTask('build', ['concat', 'uglify']);
};