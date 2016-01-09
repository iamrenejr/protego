fs = require 'fs'
{resolve} = require 'path'

module.exports = ([rq, rs, nx]) ->
	rs.writeHead 200, {"Content-Type": "text/js"}
	jsFile = fs.createReadStream resolve 'public', 'js', 'index.js'
	jsFile.pipe rs