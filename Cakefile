require 'sugar'
fs = require 'fs'
del = require 'del'
docco = require 'docco'
globby = require 'globby'
Promise = require 'bluebird'
{watch} = require 'chokidar'
{exec, spawn} = require 'child_process'
{resolve, relative, sep, dirname, join} = require 'path'

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

docs = ->
	docco_cmd = "node node_modules/docco/bin/docco --layout linear"
	globby ['Cakefile', 'server.coffee']
	.then (paths) ->
		for path in paths
			pathDir = dirname path
			docco_cmd += " -o docs/#{pathDir} #{path}"
		exec docco_cmd, (error, stdout, stderr) ->
			console.log error if error?

clean = ->
	console.log '==================='
	console.log "Cleaning the build:"
	console.log '==================='
	del ['pages/**/build/*', '!**/.gitkeep', 'db/loki.db']
	.then (paths) ->
		console.log 'Deleted: ' + relative process.cwd(), path for path in paths

style = ->
	cmd = "sass -r sass-globbing styles.scss ../build/styles.css"
	globby ['**/styles.scss']	
	.then (paths) ->

		console.log '======================='
		console.log 'Compiling SCSS files...'
		console.log '======================='
		
		new Promise (done, reject) ->
			counter = 0
			for path in paths
				console.log "SCSS to CSS: #{path}"
				dir = dirname path
				exec cmd, {cwd: dir}, (error) ->
					reject error if error?
					counter -= 1
					done() if counter == 0
				counter += 1

script = ->
	cmd = 'node node_modules/browserify/bin/cmd.js -t coffeeify --extension=".coffee" -o '
	globby ['pages/**/index.coffee', '!*/0-vendor/**', '!*/3-modules/**']
	.then (paths) ->
		
		console.log '==============================='
		console.log 'Compiling CoffeeScript files...'
		console.log '==============================='

		new Promise (done, reject) ->
			counter = 0
			for path in paths
				console.log "Coffee to JS: #{path}"
				run = cmd
				.concat resolve path, '../..', 'build'
				.concat "#{sep}index.js "
				.concat path
				exec run, (error) ->
					reject error if error?
					counter -= 1
					done() if counter == 0
				counter += 1

scriptAMD = ->
	cmd = 'node node_modules/coffee-script/bin/coffee'
	globby ['pages/3-modules/**/index.coffee']
	.then (paths) ->

		console.log '==============================='
		console.log 'Compiling CoffeeScript files...'
		console.log '==============================='

		new Promise (done, reject) ->
			counter = 0
			for path in paths
				console.log "Coffee to JS: #{path}"
				run = cmd
				.concat ' -o '
				.concat join path, '../..', 'build'
				.concat ' -c '
				.concat path
				exec run, (error) ->
					reject error if error?
					counter -= 1
					done() if counter == 0
				counter += 1

minify = ->
	console.log '==========================================='
	console.log 'Minifying all index.js and styles.css files'
	console.log '==========================================='

	new Promise (done, reject) ->
		Promise.all [
			globby ['pages/**/index.js']
			globby ['pages/**/styles.css']
		]
		.then (paths) ->

			jsCounter = 0
			for pathJS in paths[0]
				console.log 'Minify: ' + relative process.cwd(), pathJS
				exec 'minify index.js', {cwd: dirname pathJS}, (error) ->
					reject error if error?
					jsCounter -= 1
					done() if jsCounter == 0 and cssCounter == 0
				jsCounter += 1
			
			cssCounter = 0	
			for pathCSS in paths[1]
				console.log 'Minify: ' + relative process.cwd(), pathCSS
				exec 'minify styles.css', {cwd: dirname pathCSS}, (error) ->
					reject error if error?
					cssCounter -= 1
					done() if jsCounter == 0 and cssCounter == 0
				cssCounter += 1

completeBuild = ->
	console.log ' '
	console.log '==========================================='
	console.log '              Build completed'
	console.log '==========================================='

task 'docs', 'Create documentation for the source code', ->
	docs().catch (error) ->
		console.log 'ERROR! Could not generate documents'
		console.log error

task 'clean', 'Remove all the built JS, CSS files', ->
	clean().catch (error) ->
		console.log 'ERROR! Could not clean build'
		console.log error

task 'style', 'Compile SCSS into CSS', ->
	style().catch (error) ->
		console.log 'ERROR! Could not compile SASS'
		console.log error

task 'script', 'Compile Coffeescript into JS', ->
	script().then ->
		scriptAMD()
	.catch (error) ->
		console.log 'ERROR! Could not compile coffee'
		console.log error

task 'minify', 'Minify all index.js and styles.css files', ->
	minify().catch (error) ->
		console.log 'ERROR! Could not minify assets'
		console.log error

task 'build', 'Compile CSS and JS at the same time', ->
	clean().then ->
		Promise.all [style(), script(), scriptAMD()]
	.then ->
		minify()
	.then ->
		completeBuild()
	.catch (error) ->
		console.log 'ERROR! Could not build'
		console.log error

task 'test', 'Run unit tests with Mocha, Chai, and Zombie', ->
	console.log 'Not yet implemented'

task 'benchmark', 'Run performance tests with Matcha', ->
	console.log 'Not yet implemented'

task 'watch', 'Reset the server on file change', ->
	server = spinServer()
	reboot = (path) ->
		console.log "Change detected in #{path}"
		server = spinServer server
	eyes = watch ['server.coffee', 'pages/**']
	eyes.on 'change', (path) -> reboot 'server.coffee'