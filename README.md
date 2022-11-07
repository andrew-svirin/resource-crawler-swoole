# Swoole resource crawler

Swoole is PHP tool that allow implement async php-server.  
To use CPU resource more optimal is possible by Swoole.  
Server can be run in different modes: sync and async.  
In sync mode it is possible to do development as usual.  
In async mode the server is working for performance.

This project shows how Swoole can be used to crawl disk/web  
resource in multiple async requests. Project shows how server  
can be organized for optimal development.

# Usage

1. `make install` Install environment.
2. `make start` Start environment.
3. `make swoole-serve` To run async server.
4. `make php-serve` To run sync server.
5. `make node-serve` To run server to compile js.