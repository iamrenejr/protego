fs = require 'fs'
{resolve} = require 'path'

serve = (obj) ->
	{rs, statusCode, contentType, content, layout, version} = obj
	rs.writeHead statusCode, {"Content-Type": contentType}
	file = fs.createReadStream resolve 'pages', '2-layouts', layout, version, content
	file.pipe rs

module.exports = ([rq, rs, nx]) ->
	{name, ver, type} = rq.params

	switch type
		when 'css' then serve
			rs: rs
			statusCode: 200
			contentType: 'text/css'
			content: 'styles.min.css'
			layout: name
			version: ver
		when 'js' then serve
			rs: rs
			statusCode: 200
			contentType: 'application/javascript'
			content: 'index.min.js'
			layout: name
			version: ver
		else
			rs.writeHead 400, {"Content-Type": "text/html"}
			rs.end 'Bad request!'
	
	nx()