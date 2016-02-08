$ = require 'jquery'
d3 = require 'd3'
topojson = require '../../../../0-vendor/topojson/topojson.min.js'

module.exports = (parentId, world, projection) ->
	console.log 'Rendering map...'

	width = $("##{parentId}").width()
	height = $("##{parentId}").height()
	path = d3.geo.path().projection projection
	$('svg').remove()

	svg = d3.select "##{parentId}"
		.append 'svg'
		.attr 'xmlns', 'http://www.w3.org/2000/svg'
		.attr 'width', width
		.attr 'height', height
		.attr 'preserveAspectRatio', 'xMidYMid meet'

	svg.append 'path'
		.datum topojson.feature world, world.objects.subunits
		.attr 'd', path
		.style 'z-index', 1