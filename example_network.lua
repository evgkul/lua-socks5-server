return function(c,req)
	req:open()
	c:send('IT WORKS!\r')
end