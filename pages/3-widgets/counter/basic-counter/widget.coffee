#$ = require 'jquery'

module.exports = require('marko-widgets').defineComponent
	template: require './template.marko'

	getTemplateData: (state, input) ->
		header: 'Unassigned'
		count: 90
		label: 'tickets'
		footer: 'V-2201'

	init: ->
		#root = $ @el
		console.log '================'
		#console.log root
		console.log @el
		console.log '================'
		#root.children('.box.header').html 'Unassigned'
		#root.children('.box.footer').html 'V-2201'
		#root.find('.box.data.count').html '90'
		#root.find('.box.data.label').html 'tickets'