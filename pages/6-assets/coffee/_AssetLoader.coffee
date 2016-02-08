$ = require 'jquery'
Promise = require 'bluebird'
classes = window.protegoNS.classes

class classes.AssetLoader
	_deactivateCSS: ->
		$('link.activeCSS').removeClass('active').prop 'disabled', true

	_loadCSS: (id, url) =>
		css = $ "link.#{id}"
		#console.log 'css length: ' + css.length
		if css.length
			#console.log 'css active?: ' + css.hasClass 'active'
			if not css.hasClass 'active'
				@_deactivateCSS()
				css.addClass('active').prop 'disabled', false
		else
			newcss = $('<link>').prop('id', id).appendTo $ 'head'
			@_deactivateCSS()
			newcss.addClass 'active'
			.prop 'href', url
			.prop 'type', 'text/css'
			.prop 'rel', 'stylesheet'

	_loadJS: (id, url) ->
		js = $ "script.#{id}"
		if not js.length
			$ '<script>'
			.prop 'id', id
			.prop 'src', url
			.appendTo $ 'head'

	_loadHTML: (id, url) ->
		Promise.resolve $.get url
		.then (page) ->
			$(id).empty().append $ page
		.catch (error) ->
			console.log error