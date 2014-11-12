# Serve static pages based on the host header

`docker build -t marcbachmann/node-static-server .`  
`docker run -v /Users/marcbachmann/Sites:/public marcbachmann/node-static /public`


```
HOST: example.com
```
Will result in serving ./public/example.com  
Ports are ignored. So `example:8080` results in ./public/example


You can pass a directory that will be served.  
e.g. `node index.js /Users/marcbachmann/Sites`.


`docker build --tag=marcbachmann/node-static-server ./`