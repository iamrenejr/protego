require 'sugar'
$ = require 'jquery'
d3 = require 'd3'
oboe = require 'oboe'
{resolve} = require 'path'

topojson = require '../../../vendor/topojson/topojson.min.js'
redAreas = require './coffee/mockData.coffee'

animate = (svg, projection, height, width) ->
	console.log 'testhere'
	svg.selectAll 'circle'
		.data redAreas()
	.enter()
		.append 'circle'
		.attr 'class', 'ring phaseone'
		.attr 'transform', (a) -> 'translate(' + (projection a) + ')'
	.transition()
		.ease 'linear'
		.duration 100
		.attr 'class', 'ring phasetwo'
		.delay (a) -> (1000*(180+a[0])/36)-100
		.each 'end', ->
			console.log '-----------'
			d3.select(this).transition()
			.ease 'linear'
			.duration 1000
			.attr 'class', 'ring phasethree'
			.remove()
	console.log 'testhere1'
	svg.append 'line'
		.attr 'id', 'radar'
		.attr 'y1', height
	.transition()
		.ease 'linear'
		.duration 10000
		.attr 'x1', width
		.attr 'x2', width
		.remove()
	console.log 'testhere2'

$ ->
	svg = d3.select document.body
			.append 'svg'
			.attr 'preserveAspectRatio', 'xMinYMin meet'
			.attr 'width', '100%'
			.attr 'height', '100%'
	projection = d3.geo.mercator()
	height = '100%'
	width = '100%'

	oboe '/world'
	.done (data) ->
		console.log data
		console.log topojson
		svg.append 'path'
			.datum topojson.feature data, data.objects.subunits
			.attr 'd', d3.geo.path().projection projection
		console.log 'Got here'
		animate svg, projection, height, width
		console.log 'Got hereA'
		(->
			animate svg, projection, height, width
		).every 10000
		console.log 'Got hereB'