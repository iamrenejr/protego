return (target, opts, data) =>
	dom = $ "##{target} > .box"
	dom.find(item.key).html item.value for item in opts