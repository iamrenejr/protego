fs = require 'fs'
{resolve} = require 'path'

module.exports = ([rq, rs, nx]) ->
	rs.writeHead 200, {"Content-Type": "application/json"}
	{name} = rq.params
	dataFile = fs.createReadStream resolve 'public', 'data', "#{name}.json"
	dataFile.pipe rs