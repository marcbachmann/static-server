# Serve static pages based on the host header

`docker pull marcbachmann/static-server`  
`docker run -v $(pwd):/public -e SERVE_DIRECTORY=/public marcbachmann/node-static`


```
HOST: example.com
```

Will result in serving /public/example.com  
Ports are ignored. So `example:8080` results in /public/example


If you're using a load balancer, you can pass TRUST_PROXY=loopback  
`docker run -v $(pwd):/public -e TRUST_PROXY=true marcbachmann/node-static`
