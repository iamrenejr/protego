# Require the dependencies
require 'sugar'
fs = require 'fs'
util = require 'util'
loki = require 'lokijs'
domain = require 'domain'
restify = require 'restify'
Promise = require 'bluebird'
socketio = require 'socket.io'
{resolve} = require 'path'
{spawn} = require 'child_process'

# Require the routes directory
requireDir = require 'require-dir'
require('coffee-script/register')
routes = requireDir 'routes', recurse: true

# Require the marko adapter
require('marko/node-require').install();

# Activate the domain
d = domain.create()
d.run ->

	# Create the database
	db = new loki 'db/loki.db'

	Promise.resolve db.loadDatabase {}
	.then ->

		# Create the collection if it doesn't exist
		db.addCollection 'dashboards' if not db.getCollection 'dashboards'

		# Create the web server and use middleware
		server = restify.createServer name: 'Protego'
		server.use restify.gzipResponse()
		server.use restify.bodyParser()
		server.pre restify.pre.sanitizePath()
		server.use restify.CORS()
		server.use restify.fullResponse()

		io = socketio.listen server.server

		# Serve assets
		server.get '/assets/:type', (args...) -> routes.utils.serveAssets args
		server.get '/widgets/:format/:name/:type', (args...) -> routes.utils.serveWidgets args
		server.get '/layouts/:name/:ver/:type', (args...) -> routes.utils.serveLayouts args
		server.get {path: '/', version: '1.0.0'}, (args...) -> routes.utils.serveDashboards args, 'v1'

		# Manipulate DB
		server.get '/api/dashboards', (args...) -> routes.dashboards.get.all args, db
		server.get '/api/dashboards/:name', (args...) -> routes.dashboards.get.record args, db
		server.post '/api/dashboards/:name', (args...) -> routes.dashboards.post.record args, db
		#server.put '/dashboards/:name', (args...) -> routes.dataView.v1.put.put_one_dataset args, db
		#server.del '/dashboards/:name', (args...) -> routes.dataView.v1.del.delete_one_dataset args, db

		# WS
		server.get '/api/layouts', (args...) -> routes.layouts.get.record args
		server.get '/api/widgets', (args...) -> routes.widgets.get.record args

		# Serve data
		server.get '/data/:name', (args...) -> routes.utils.serveJSON args

		io.sockets.on 'connection', (socket) ->
			socket.on 'change active dashboard', (data) ->
				io.emit 'render world object', dashboards.findOne name: data

			socket.on 'request landing world object', ->
				dashboards = db.getCollection 'dashboards'
				dashboards.findOne name: 'landing'
				console.log dashboards.findOne name: 'landing'
				socket.emit 'render world object', dashboards.findOne name: 'landing'
				###
				title: 'Security Dashboard'
				layout:
					name: 'counterWall'
					version: 'v1'
				widgets: [
					{name: 'nomargin', format: 'header', target: 'header'}
					{name: 'basic', format: 'counter', target: '1'}
					{name: 'basic', format: 'counter', target: '2'}
					{name: 'basic', format: 'counter', target: '3'}
					{name: 'basic', format: 'counter', target: '4'}
					{name: 'basic', format: 'counter', target: '5'}
					{name: 'basic', format: 'counter', target: '6'}
					{name: 'basic', format: 'counter', target: '7'}
					{name: 'basic', format: 'counter', target: '8'}
					{name: 'basic', format: 'counter', target: '9'}
					{name: 'basic', format: 'counter', target: '10'}
					{name: 'basic', format: 'counter', target: '11'}
					{name: 'basic', format: 'counter', target: '12'}
					{name: 'basic', format: 'counter', target: '13'}
					{name: 'basic', format: 'counter', target: '14'}
					{name: 'basic', format: 'counter', target: '15'}
					{name: 'basic', format: 'counter', target: '16'}
					{name: 'basic', format: 'counter', target: '17'}
					{name: 'basic', format: 'counter', target: '18'}
					{name: 'basic', format: 'counter', target: '19'}
				]
				###

		# Adapter setup here
		# Placeholder
		# Placeholder

		# After each operation, log if there was an error
		server.on 'after', (req, res, route, error) ->
			console.log "======= After call ======="
			console.log "Error: #{error}"
			console.log "=========================="

		# Log when the web server starts up
		server.listen 8000, -> console.log "#{server.name}[#{process.pid}] online: #{server.url}"
		console.log "#{server.name} is starting..."

	.catch (error) ->
		db.saveDatabase()
		console.warn error

d.on 'error', (error) ->
	console.warn error