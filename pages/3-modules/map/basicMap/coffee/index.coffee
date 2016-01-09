require 'sugar'
$ = require 'jquery'
d3 = require 'd3'
oboe = require 'oboe'
{resolve} = require 'path'

redAreas = require './coffee/mockData.coffee'
beepCircle = require './coffee/beepCircle.coffee'
moveLine = require './coffee/moveLine.coffee'
render = require './coffee/render.coffee'
	
animate = (projection, duration) ->
	console.log 'Triggering animations'
	data = redAreas()
	(-> data = redAreas()).every 30000
	(-> 
		beepCircle data, projection, duration
		moveLine 'mapContainer', duration
	).every duration

createBasicMap = (projection) ->
	console.log 'Rendering page...'

	width = $('#mapContainer').width()
	height = $('#mapContainer').height()

	projection
	.scale 100*width/640
	.translate [width/2, height/2]

	oboe '/data/world'
	.done (world) -> render 'mapContainer', world, projection

$ ->
	if $('#basicMap').length
		projection = d3.geo.equirectangular()
		createBasicMap projection
		window.onresize = -> createBasicMap projection

		duration = 10000
		animate projection, duration