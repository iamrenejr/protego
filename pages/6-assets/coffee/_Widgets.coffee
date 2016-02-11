require 'sugar'
$ = require 'jquery'
d3 = require 'd3'
oboe = require 'oboe'
Promise = require 'bluebird'

Parent = window.protegoNS.classes.AssetLoader
classes = window.protegoNS.classes
sockets = window.protegoNS.sockets
dataUrl = window.protegoNS.urls.dataUrl

protocol = window.location.protocol
host = window.location.hostname
url = "#{protocol}//#{host}:7777"

class classes.Widgets extends Parent
	constructor: (@_name, @_format, @_target, @_opts={}, @_data=false) ->
	_factory: -> console.log 'Replace this'
	_render: (data) => @_factory @_target, @_opts, data
	_listener: false

	load: =>
		@_loadCSS "#{@_name}_#{@_format}_widgetCSS", "/widgets/#{@_format}/#{@_name}/css"
		@_loadHTML "##{@_target}", "/widgets/#{@_format}/#{@_name}/html"

		$.getScript "/widgets/#{@_format}/#{@_name}/js", (js) =>
			@_factory = eval js # have to live with eval for now
			if @_data == 'false' or @_data == false
				@_render null
			else
				console.log "#{dataUrl}/resource/1/dataView/#{@_data}"
				console.log @_listener
				$.get "#{dataUrl}/resource/1/dataView/#{@_data}", (data) =>
					console.log '------$.get------'
					console.log data
					@_render data
				console.log @_listener
				unless @_listener
					console.log 'listener'
					sockets.dataSocket.on 'new data delivery', (data) =>
						console.log '------SocketIO------'
						console.log data
						@_render data
					sockets.dataSocket.emit 'subscribe to filter', @_data
				@_listener = true

	unload: =>
		sockets.dataSocket.removeListener 'new data delivery', @_render
		@_listener = true