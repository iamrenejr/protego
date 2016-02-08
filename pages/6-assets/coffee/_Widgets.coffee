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
	constructor: (@_name, @_format, @_target, @_data=false) ->
	_render: (data) => @_factory @_target, data
	_listener: true

	load: =>
		@_loadCSS "#{@_name}_#{@_format}_widgetCSS", "/widgets/#{@_format}/#{@_name}/css"
		@_loadHTML "#widget_#{@_target}", "/widgets/#{@_format}/#{@_name}/html"

		unless !@_data
			$.getScript "/widgets/#{@_format}/#{@_name}/js", (js) =>
				@_factory = eval js # have to live with eval for now
				$.get "#{dataUrl}/resource/1/dataView/#{@_data}", (data) =>
					@_render data
			unless @_listener
				sockets.dataSocket.on 'new data delivery', @_render
				sockets.dataSocket.emit 'subscribe to filter', @_data
			@_listener = false

	unload: =>
		sockets.dataSocket.removeListener 'new data delivery', @_render
		@_listener = true