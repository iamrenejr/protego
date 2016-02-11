fs = require 'fs'
globby = require 'globby'
{resolve, dirname, basename} = require 'path'

module.exports = ([rq, rs, nx]) ->
	rs.writeHead 200, {"Content-Type": "application/json"}
	globby ['pages/2-layouts/*/*']
	.then (paths) ->
		layouts = {}
		for path, index in paths
			lname = basename dirname path
			layouts[lname] ?= []
			layouts[lname].push basename path
			if index+1 == paths.length
				rs.write JSON.stringify layouts
				rs.end()
				nx()