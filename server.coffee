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
d.on 'error', (error) -> console.log error

# Create the database
db = new loki 'db/loki.db'

# Create the web server and use middleware
server = restify.createServer name: 'Protego'
server.use restify.gzipResponse()
server.use restify.bodyParser()
server.pre restify.pre.sanitizePath()
server.use restify.CORS()
server.use restify.fullResponse()

io = socketio.listen server.server

server.get '/test/handler', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "application/javascript"}
	stream = fs.createReadStream './test/handler.js'
	stream.pipe rs

server.get '/test/instance', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "application/javascript"}
	stream = fs.createReadStream './test/instance.js'
	stream.pipe rs

server.get '/test/css', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/css"}
	stream = fs.createReadStream './test/style.css'
	stream.pipe rs

server.get '/test/widget', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	template = resolve 'test', 'widget.marko'
	view = require template
	view.render {}, rs

server.get '/test/page', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	template = resolve 'test', 'webpage.marko'
	view = require template
	view.render {}, rs

# Serve assets
server.get '/assets/:type', (args...) -> routes.utils.serveAssets args

# Serve widgets
server.get '/widgets/:format/:name/:type', (args...) -> routes.utils.serveWidgets args

# Serve layout CSS and JS
server.get '/layouts/:name/:ver/:type', (args...) -> routes.utils.serveLayouts args

# Serve dashboards
server.get
	path: '/'
	version: '1.0.0'
, (args...) -> routes.utils.serveDashboards args, 'v1'

# Serve data
server.get '/data/:name', (args...) -> routes.utils.serveJSON args

io.sockets.on 'connection', (socket) ->
	socket.on 'request landing world object', ->
		socket.emit 'render world object',
			title: 'Security Dashboard'
			layout:
				name: 'counterWall'
				version: 'v1'
			widgets: [
				{name: 'nomargin', format: 'header', data: 'test', target: 'header'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot1'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot2'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot3'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot4'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot5'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot6'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot7'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot8'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot9'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot10'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot11'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot12'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot13'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot14'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot15'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot16'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot17'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot18'}
				{name: 'basic', format: 'counter', data: 'test', target: 'slot19'}
			]

# Adapter setup here
# Placeholder
# Placeholder

# After each operation, log if there was an error
server.on 'after', (req, res, route, error) ->
	console.log "======= After call ======="
	console.log "Error: #{error}"
	console.log "=========================="

# Run the server under an active domain
d.run ->
	# Log when the web server starts up
	server.listen 8000, -> console.log "#{server.name}[#{process.pid}] online: #{server.url}"
	console.log "#{server.name} is starting..."