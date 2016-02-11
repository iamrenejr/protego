return (target, opts, data) ->
	dom = $ "##{target} > .header"
	dom.find(item.key).html item.value for item in opts