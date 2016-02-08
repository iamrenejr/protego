fs = require 'fs'
{resolve, sep} = require 'path'

module.exports = ([rq, rs, nx], version) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	template = resolve 'pages', '6-assets', 'marko', 'template.marko'
	view  = require template
	view.render {}, rs