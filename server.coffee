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

# Serve widgets
server.get '/widgets/:format/:name/:type', (args...) -> routes.utils.serveWidgets args

# Serve layout CSS and JS
server.get '/layouts/:name/:ver/:type', (args...) -> routes.utils.serveLayouts args

# Serve dashboards
server.get
	path: '/:name'
	version: '1.0.0'
, (args...) -> routes.utils.serveDashboards args, 'v1'

# Serve data
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
	server.listen 8000, -> console.log "#{server.name}[#{process.pid}] online: #{server.url}"
	console.log "#{server.name} is starting..."