fs = require 'fs'
{resolve, sep} = require 'path'

module.exports = ([rq, rs, nx], version) ->
	{name} = rq.params

	rs.writeHead 200, {"Content-Type": "text/html"}
	template = resolve 'pages', '2-layouts', name, version, 'marko', 'template.marko'
	view  = require template

	view.render
		name: name
		header: 'header/panicHeader'
		primary: 'map/basicMap'
		secondary: 'test'
		tertiary: 'test'
		quaternary: 'test'
		footer: 'test'
	, rs