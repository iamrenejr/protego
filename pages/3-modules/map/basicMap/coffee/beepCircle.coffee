d3 = require 'd3'

module.exports = (data, projection, duration) ->
	d3.select 'svg'
		.selectAll 'circle'
		.data data
	.enter()
		.append 'circle'
		.attr 'r', 1
		.attr 'opacity', 0
		.attr 'transform', (a) -> 'translate(' + (projection a) + ')'
		.style 'stroke-width', 9
		.style 'fill', 'none'
	.transition()
		.ease 'linear'
		.duration 100
		.attr 'r', 2
		.attr 'opacity', 1
		.style 'stroke-width', 8
		.delay (a) -> duration*(180+a[0])/360
		.each 'end', ->
			d3.select(this).transition()
			.ease 'linear'
			.duration 1000
			.attr 'r', 40
			.attr 'opacity', 0
			.style 'stroke', 'brown'
			.style 'stroke-width', 0
			.remove()