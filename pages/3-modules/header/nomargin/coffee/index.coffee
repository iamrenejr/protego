return (target, data) ->
	dom = $ "#widget_#{target} > .header"
	dom.find('.title').html 'Security Operations'