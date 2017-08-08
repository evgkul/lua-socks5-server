local copas=require "copas"
--local handler=require('handler')           --Uncomment on production(if you will use THIS on production...)
--local network=require('example_network')   --Uncomment on production(if you will use THIS on production...)


copas.addserver(assert(socket.bind('127.0.0.1',8889)),
	function(c) return (handler or dofile('handler.lua'))(copas.wrap(c),network or dofile('example_network.lua'), c:getpeername()) end
)
copas.loop()
