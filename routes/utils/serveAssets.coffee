fs = require 'fs'
{resolve} = require 'path'

serve = (obj) ->
	{rs, statusCode, contentType, content} = obj
	rs.writeHead statusCode, {"Content-Type": contentType}
	file = fs.createReadStream resolve 'pages', '6-assets', 'build', content
	file.pipe rs

module.exports = ([rq, rs, nx]) ->
	{type} = rq.params

	switch type
		when 'css' then serve
			rs: rs
			statusCode: 200
			contentType: 'text/css'
			content: 'styles.min.css'
		when 'js' then serve
			rs: rs
			statusCode: 200
			contentType: 'application/javascript'
			content: 'index.js'
		else
			rs.writeHead 400, {"Content-Type": "text/html"}
			rs.end 'Bad request!'
	
	nx()