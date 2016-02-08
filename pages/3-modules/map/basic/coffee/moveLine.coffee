$ = require 'jquery'
d3 = require 'd3'

module.exports = (parentId, duration) ->
	{x, y, width, height} = document.getElementsByTagName('path')[0].getBBox()

	d3.select 'svg'
		.append 'line'
		.attr 'x1', x
		.attr 'x2', x
		.attr 'y2', y
		.attr 'y1', y + height
		.style 'stroke-width', 4
	.transition()
		.ease 'linear'
		.duration duration
		.attr 'x1', x + width
		.attr 'x2', x + width
		.remove()