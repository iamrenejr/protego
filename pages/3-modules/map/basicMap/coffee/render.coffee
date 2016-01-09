$ = require 'jquery'
d3 = require 'd3'
topojson = require '../../../../vendor/topojson/topojson.min.js'

module.exports = (parentId, world, projection) ->
	console.log 'Rendering map...'

	lineStroke = 'rgba(21,171,195,1.0)'
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
		.style 'border', "1px solid #{lineStroke}"

	svg.append 'path'
		.datum topojson.feature world, world.objects.subunits
		.attr 'd', path
		.style 'z-index', 1

	yAxis = d3.range 0, width, width/25
	xAxis = d3.range 0, height, height/25

	d3.select 'svg'
		.selectAll 'line.vertical'
		.data yAxis
	.enter()
		.append 'line'
		.attr 'x1', (d) -> d
		.attr 'y1', 0
		.attr 'x2', (d) -> d
		.attr 'y2', height
		.style 'stroke', lineStroke
		.style 'stroke-width', 1

	d3.select 'svg'
		.selectAll 'line.horizontal'
		.data xAxis
	.enter()
		.append 'line'
		.attr 'x1', 0
		.attr 'y1', (d) -> d
		.attr 'x2', width
		.attr 'y2', (d) -> d
		.style 'stroke', lineStroke
		.style 'stroke-width', 1