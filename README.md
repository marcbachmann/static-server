# Serve static pages based on the host header

This Dockerfile only exists to leverage from the pull & build in ansible. If you know a better solution, let me know.


    docker build -t marcbachmann/node-static-server .
    docker run -v /Users/marcbachmann/Sites:/public marcbachmann/node-static /public


The following header will result in serving ./public/example.com
 
    HOST: example.com


Ports are ignored. So `example.com:8080` results in ./public/example.com


The server only accepts one argument at the moment.  
You can pass the directory path which should be served.  
e.g. `node index.js /Users/marcbachmann/Sites`.
