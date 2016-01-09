# Require the dependencies
require 'sugar'
fs = require 'fs'
util = require 'util'
loki = require 'lokijs'
domain = require 'domain'
restify = require 'restify'
Promise = require 'bluebird'
{resolve} = require 'path'
{spawn} = require 'child_process'

readFile = Promise.promisify fs.readFile

# Require the routes directory
requireDir = require 'require-dir'
require('coffee-script/register')
routes = requireDir 'routes', recurse: true

# Require the marko adapter
require('marko/node-require').install();

# Activate the domain
d = domain.create()
d.on 'error', (error) -> console.log error

# Create the database connection
DB = require resolve process.cwd(), 'DB', 'DB.coffee'
db = new DB

# Create the web server and use middleware
server = restify.createServer name: 'Protego'
server.use restify.bodyParser()
server.pre restify.pre.sanitizePath()
server.use restify.CORS()
server.use restify.fullResponse()

# Define REST API: dashboard
server.get '/page/:name', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	{name} = rq.params

	data =
		layout: 'basicDashboard'
		version: 1

	template = resolve process.cwd(), 'layouts', data.layout, "v#{data.version}", 'template.marko'
	view  = require template
	view.render
		name: name
		title: "Dashboard: #{name}"
		version: data.version
		layout: data.layout
		topRowWidgets: ['Total IMP1s', 'Unassigned IMP1s', 'Total IMP2s']
		bottomRowWidget: ['test4', 'test5']
	, rs

# Define REST API: layout
server.get '/style/:layout/:version', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/css"}
	{layout, version} = rq.params

	cssFile = resolve process.cwd(), 'layouts', layout, version, 'style.css'
	readFile cssFile
	.then (contents) -> rs.write contents
	.catch (error) -> rs.write '{"error": "Error occurred"}'
	.finally -> rs.end()

# Define REST API: widget
server.get '/widget/:format/:type/:name', (rq, rs, nx) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	{format, type, name} = rq.params

	widget = resolve process.cwd(), 'widgets', format, type, 'template.marko'
	view  = require widget
	view.render
		name: name
		title: "Widget: #{name}"
		format: format
		type: type
		tableTeamData: ['VBlock', 'DBA', 'Tools', 'UNIX', 'Wintel', 'BFS', 'CAF']
	, rs

# Serve JS, CSS, and JSON
server.get '/script', (args...) -> routes.utils.serveJS args
server.get '/style', (args...) -> routes.utils.serveCSS args
server.get '/data/:name', (args...) -> routes.utils.serveJSON args

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
	server.listen 80, -> console.log "#{server.name}[#{process.pid}] online: #{server.url}"
	console.log "#{server.name} is starting..."