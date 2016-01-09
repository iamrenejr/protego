fs = require 'fs'
{resolve} = require 'path'

module.exports = ([rq, rs, nx]) ->
	rs.writeHead 200, {"Content-Type": "text/css"}
	cssFile = fs.createReadStream resolve 'public', 'css', 'styles.css'
	cssFile.pipe rs