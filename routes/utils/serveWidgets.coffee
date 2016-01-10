fs = require 'fs'
{resolve} = require 'path'

serve = (obj) ->
	{rs, statusCode, contentType, content, format, name} = obj
	rs.writeHead statusCode, {"Content-Type": contentType}
	file = fs.createReadStream resolve 'pages', '3-modules', format, name, content
	file.pipe rs

stream = (obj) ->
	{rs, statusCode, contentType, content, format, name} = obj
	rs.writeHead statusCode, {"Content-Type": contentType}
	template = resolve 'pages', '3-modules', format, name, 'marko', content
	view  = require template

	view.render
		format: format
		name: name
	, rs

module.exports = ([rq, rs, nx]) ->
	{format, name, type} = rq.params

	switch type
		when 'css' then serve
			rs: rs
			statusCode: 200
			contentType: 'text/css'
			content: 'styles.min.css'
			format: format
			name: name
		when 'js' then serve
			rs: rs
			statusCode: 200
			contentType: 'application/javascript'
			content: 'index.min.js'
			format: format
			name: name
		when 'html' then stream
			rs: rs
			statusCode: 200
			contentType: 'text/html'
			content: 'template.marko'
			format: format
			name: name
		else
			rs.writeHead 400, {"Content-Type": "text/html"}
			rs.end 'Bad request!'
	
	nx()