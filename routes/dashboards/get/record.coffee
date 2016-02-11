require 'sugar'

module.exports = ([rq, rs, nx], db) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	{name} = rq.params

	dashboards = db.getCollection 'dashboards'
	rs.write JSON.stringify Object.reject (dashboards.findOne name: name), 'meta', '$loki'
	rs.end()

	nx()