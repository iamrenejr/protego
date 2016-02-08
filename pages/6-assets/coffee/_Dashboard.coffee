$ = require 'jquery'
classes = window.protegoNS.classes
{Layout, Widgets} = classes

class classes.Dashboard
	widgets: []

	constructor: ({@title, layout, widgets}) ->
		@layout = new Layout layout.name, layout.version
		@widgets.push new Widgets name, format, target, data for {name, format, data, target} in widgets

	load: =>
		$('title').html @title
		@layout.load()
		widget.load() for widget in @widgets

	unload: =>
		@layout.unload()
		widget.unload() for widget in @widgets