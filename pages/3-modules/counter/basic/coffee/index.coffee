return (target, data) =>
	dom = $ "#widget_#{target} > .box"
	dom.children('.box.header').html 'Unassigned'
	dom.children('.box.footer').html 'V-2201'
	dom.find('.box.data.count').html '90'
	dom.find('.box.data.label').html 'tickets'