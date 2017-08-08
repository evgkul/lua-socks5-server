local ch=string.char
local b=string.byte
--local target=dofile('target.lua')

function hex(IN)
    local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
    while IN>0 do
        I=I+1
        IN,D=math.floor(IN/B),math.mod(IN,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end

print('Executed handler.lua')

return function(c, network, host, port)
	local gsym=function() return c:receive(1) end
	local peer = host .. ":" .. port
	print("connection from", peer)
	c:receive(1) --Первый символ, указывает версию...
	local authmethodsnum=b(c:receive(1))
	local amethods={}
	for i=1,authmethodsnum do
		local m=b(gsym())
		print('Authmethod: ',m)
		amethods[i]=m
	end
	
	print('Finished receiving first message...')
	
	c:send(ch(5)..ch(0))
	print('Finished answering to it')
	
	local req={}
	
	gsym()
	
	req.cmd=b(gsym())
	gsym()
	req.atype=b(gsym())
	print('Request cmd: ',req.cmd,'; Request address type: ',req.atype)
	if req.atype==3 then
		print('Receiving domain!')
		req.domain=c:receive(b(gsym()))
		local pnum1,pnum2=b(gsym()),b(gsym())
		req.port=pnum1*256+pnum2
		print('Domain is '..req.domain,';port is ',req.port)
		req.res=0
		--req.success=true
	else
		req.res=7
		print('Unsupported address type!')
	end
	req.open=function(self) c:send(ch(5)..ch(req.res)..ch(0)..ch(1)..ch(0)..ch(0)..ch(0)..ch(0)..ch(0)..ch(0)) end
	print('Finished answering!')
	if req.res==0 then
		network(c,req)
	end
end