winston = require('winston')
logger = new winston.Logger
  levels: { error: 3, request: 2, debug: 1, info: 1}
  transports: [new (winston.transports.Console)(timestamp: true)]

serveStatic = require('serve-static')
directory = require('path').resolve(dir) if dir = process.env.SERVE_DIRECTORY
root =  directory || __dirname + '/public'

app = require('express')()
app.disable('x-powered-by')
app.set('trust proxy', process.env.TRUST_PROXY) if process.env.TRUST_PROXY

app.use (req, res, next) ->
  logger.request("ip=#{req.ip} method=#{req.method} hostname=#{req.hostname} url=#{req.originalUrl} useragent=\"#{req.headers['user-agent']}\"")
  next()

app.use(require('compression')())

app.use (req, res, next) ->
  res.setHeader('X-Serve', req.hostname)
  serveStatic("#{root}/#{req.hostname}")(req, res, next)

app.use (req, res, next) ->
  req.url = '/'
  serve = serveStatic "#{root}/#{req.hostname}",
    setHeaders: (res, path) ->
      res.status(404)
  serve(req, res, next)


app.use (req, res, next) ->
  req.url = '/'
  serveStatic("#{root}/default")(req, res, next)

app.use (req, res, next) ->
  res.sendStatus(404)


require('dns').lookup require('os').hostname(), (err, host, fam) ->
  throw err if err

  port = process.env.PORT || 0
  server = app.listen port, ->
    logger.debug('Listening on http://%s:%s', host, server.address().port, root)
    logger.debug('Serving %s', root)


process.on 'uncaughtException', (err) ->
  logger.error(err)
  process.exit(1)
