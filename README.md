# lua-socks5-server
Simple socks5 server written in lua. Could be used for creating simple vpn analog

Requirments:
  Copas

Example: just run example\_srv.lua and configure your browser to use 127.0.0.1:8889 as socks5 proxy

Structure: handler.lua contains the protocol, example\_network.lua contains function, which receives socket and request data.
WARNING: before doing anything with socket call req:open() first to answer the socks request!
