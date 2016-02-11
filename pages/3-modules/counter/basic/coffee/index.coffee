return (target, opts, data) =>
	data = JSON.parse data if typeof data == 'string'
	dom = $ "##{target} > .box"
	dom.find(item.key).html item.value for item in opts
	dom.find('.data-slot').html data.Result.$value if data
	console.log data