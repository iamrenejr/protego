fs = require 'fs'
{resolve} = require 'path'

module.exports = ([rq, rs, nx]) ->
	{name} = rq.params

	rs.writeHead 200, {"Content-Type": "application/json"}
	file = fs.createReadStream resolve 'pages', '6-assets', 'data', 'world.json'
	file.pipe rs