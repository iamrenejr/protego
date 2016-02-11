require 'sugar'
$ = require 'jquery'

window.protegoNS ?= {}
window.protegoNS.classes ?= {}
window.protegoNS.sockets ?= {}
window.protegoNS.urls ?= {}
sockets = window.protegoNS.sockets
urls = window.protegoNS.urls

# Create the target socket url
protocol = window.location.protocol
host = window.location.hostname
urls.dataUrl = "#{protocol}//#{host}:7777"

#(-> require 'pages/3-modules/**/coffee') # This might remove the need for eval
require './_AssetLoader'
require './_Widgets'
require './_Layout'
require './_Dashboard'

sockets.dataSocket = (require 'socket.io-client') urls.dataUrl
sockets.ownSocket = (require 'socket.io-client') '/'

dashboards = {}

$ ->
	sockets.ownSocket.on 'render world object', (world) ->
		unless dashboards[world.title]?
			dashboards[world.title] = new window.protegoNS.classes.Dashboard world
		dashboards[world.title].load()

	sockets.ownSocket.emit 'request landing world object'

#Promise.resolve $.get "/layouts/panicBoard/v1/html"
#.then (data) ->
#	$('body').append $ data