return function(c,req)
	req:open()
	c:send('IT WORKS!\r Your target is '..req.target..' and port is '..req.port)
end