# 
# Module dependencies.
# 
express = require 'express'
app = module.exports = express.createServer()

# Configuration
app.configure () ->
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser()
	app.use require './uid'
	app.use app.router

app.configure 'development', () ->
	app.use express.errorHandler
		dumpExceptions: true
		showStack: true
	app.set 'memcached', '127.0.0.1:11211'
	app.set 'mongobase', 'mongo://localhost/default'

app.configure 'production', () ->
	app.use express.errorHandler()
	app.set 'memcached', process.env.MEMCACHED
	app.set 'mongobase', process.env.MONGODB

# Routes
require './api'

app.listen 3000, () ->
  console.log "Express server listening on port #{app.address().port} in #{app.settings.env} mode"
