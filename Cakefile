require 'sugar'
fs = require 'fs'
del = require 'del'
docco = require 'docco'
globby = require 'globby'
Promise = require 'bluebird'
coffeeify = require 'coffeeify'
browserify = require 'browserify'
{exec, spawn} = require 'child_process'
{watch} = require 'chokidar'
{files} = require 'node-dir'
{resolve, sep, dirname, extname, basename} = require 'path'

option '-t', '--test', 'Does nothing'

spinServer = (server) ->
	if server?
		console.log "Server [pid #{server.pid}] is shutting down"
		process.kill server.pid, 'SIGTERM'
	server = spawn 'node' , ['node_modules/coffee-script/bin/coffee' , 'server.coffee']
	console.log "Server [pid #{server.pid}] is starting up"
	server.on 'error', (err) -> throw err if err?
	server.stdout.on 'data', (data) -> console.log data.toString()
	server.stderr.on 'data', (data) -> console.log data.toString()
	server.on 'exit', -> console.log "Server [pid #{server.pid}] has shut down"
	server

task 'docs', 'Create documentation for the source code', ->
	docco_cmd = "node node_modules/docco/bin/docco --layout linear"
	globby ['Cakefile', 'server.coffee']
	.then (paths) ->
		for path in paths
			pathDir = dirname path
			docco_cmd += " -o docs/#{pathDir} #{path}"
		exec docco_cmd, (error, stdout, stderr) ->
			reject error if error?
	.catch (error) ->
		console.log 'ERROR! Could not generate documents'
		console.log error

task 'style', 'Compile SCSS into CSS', ->
	sass_cmd = "sass -r sass-globbing styles.scss ../styles.css"
	globby ['**/styles.scss']
	.then (paths) ->
		for path in paths
			sass_dir = dirname path
			exec sass_cmd, cwd: sass_dir

task 'script', 'Compile Coffeescript into JS', ->
	browserify_cmd = "browserify -t coffeeify -o "
	globby ['pages/**/*.coffee', '!*/0-vendor/**', '!**/index.coffee']
	.then (paths) ->
		mapped = paths.map (path) -> resolve path, '../..'
		zipped = mapped.zip paths
		groups = zipped.groupBy (item) -> item[0]
		finale = {}
		for item of groups
			finale[item] = []
			finale[item].push group[1] for group in groups[item]
		for item of finale
			run = browserify_cmd
			.concat "#{item}#{sep}index.js "
			.concat finale[item].join ' '
			exec run

task 'minify', 'Minify all index.js and styles.css files', ->
	minifyjs_cmd = 'minify index.js'
	globby ['pages/**/index.js']
	.then (paths) -> exec minifyjs_cmd, cwd: dirname path for path in paths
	
	minifycss_cmd = 'minify styles.css'
	globby ['pages/**/styles.css']
	.then (paths) -> exec minifycss_cmd, cwd: dirname path for path in paths

task 'build', 'Compile CSS and JS at the same time', ->
	invoke 'style'
	invoke 'script'
	(-> invoke 'minify').delay 5000

task 'test', 'Run unit tests with Mocha, Chai, and Zombie', ->
	console.log 'Not yet implemented'

task 'benchmark', 'Run performance tests with Matcha', ->
	console.log 'Not yet implemented'

task 'clean', 'Clean the build', ->
	del ['db/*', '!db/.gitkeep']
	.then (paths) ->
		console.log 'Deleted files: ' + paths.join ', '
	.catch (error) ->
		console.log 'ERROR! Could not clean build'
		console.log error

task 'watch', 'Reset the server on file change', ->
	server = spinServer()
	reboot = (path) ->
		console.log "Change detected in #{path}"
		server = spinServer server
	eyes = watch ['server.coffee', 'layouts/**']
	eyes.on 'change', (path) -> reboot 'server.coffee'