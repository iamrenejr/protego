Parent = window.protegoNS.classes.AssetLoader
classes = window.protegoNS.classes

class classes.Layout extends Parent
	constructor: (@_name, @_version) ->

	load: =>
		@_loadCSS "#{@_name}_layoutCSS", "/layouts/#{@_name}/#{@_version}/css"
		@_loadHTML '#activePage', "/layouts/#{@_name}/#{@_version}/html"

	unload: ->