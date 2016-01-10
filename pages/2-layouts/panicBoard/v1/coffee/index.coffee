require 'sugar'
$ = require 'jquery'

(->
	alert 'naooonn'
	header = require './header'
	console.log header()
).delay 1000