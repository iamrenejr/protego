# Require the dependencies
require 'sugar'
util = require 'util'
loki = require 'lokijs'
domain = require 'domain'
restify = require 'restify'
{resolve} = require 'path'
{spawn} = require 'child_process'

# Require the routes directory
requireDir = require 'require-dir'
require('coffee-script/register')
routes = requireDir 'routes', recurse: true

# Require the adapter
# Placeholder

# Activate the domain
d = domain.create()
d.on 'error', (error) -> console.log error

# Create the database connection
dbFile = resolve process.cwd(), 'db', 'loki.json'
db = new loki dbFile,
	autosave: true
	autosaveInterval: 1000

# Get or create the collection
# Placeholder
# Placeholder

# Before doing anything, make sure the database is already connected
db.loadDatabase {}, ->
	# Ensure that the database is always up to date
	(-> db.loadDatabase()).every 5000
	(-> db.saveDatabase()).every 1000

	# Create the web server and use middleware
	server = restify.createServer name: 'Protego'
	server.use restify.bodyParser()
	server.pre restify.pre.sanitizePath()
	server.use restify.CORS()
	server.use restify.fullResponse()
	
	# Define REST API: dashboard
	server.get '/page/:name', (args...) -> routes.page args, db

	# Define REST API: layout
	# Define REST API: widget

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