root = exports ? window
console.log (exports ? window)
console.log root

$ = require 'jquery'
Promise = require 'bluebird'

class window.Widget
	constructor: (@name) ->
		console.log @name

$ ->
	console.log 'bla bla bla'

	Promise.all [
		Promise.resolve $.get '/test/css'
		Promise.resolve $.get '/test/widget'
	]
	.then (data) ->
		$ '<link>'
		.prop 'rel', 'stylesheet'
		.prop 'type', 'text/css'
		.prop 'href', '/test/css'
		.appendTo $ 'head'
		$('body').append $ data[1]