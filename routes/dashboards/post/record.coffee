require 'sugar'

module.exports = ([rq, rs, nx], db) ->
	rs.writeHead 200, {"Content-Type": "text/html"}
	dashboards = db.getCollection 'dashboards'

	pass = false
	{title, layout, widgets} = Object.reject rq.params, 'name'
	{name, version} = layout
	pass = true if !!title and !!widgets and !!layout and !!name and !!version

	check = true
	if Object.isArray widgets
		for {name, format, target} in widgets
			check = false if !name and !format and !target
	else
		check = false
	
	{name} = rq.params
	record = dashboards.findOne name: name
	if not record
		verified = true
	else
		verified = false

	if pass and check and verified
		dashboards.insert
			name: name
			title: title
			layout: layout
			widgets: widgets
		db.saveDatabase()
		rs.end()
	else
		rs.end 'You did not supply the correct inputs'
	nx()