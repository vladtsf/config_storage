# 
# Module dependencies.
# 
express = require 'express'
program = require 'commander'
pkg = require '../package'
app = module.exports = express.createServer()

# CLI args
program
	.version(pkg.version)
	.option('-p, --port <port>', 'REST service port', 3000)
	.option('-b, --mongo <string>', 'MongoDB connection string', 'mongo://localhost/default')
	.option('-m, --memcached <string>', 'Memcached servers list', '127.0.0.1:11211')
	.option('--memcached-prefix <string>', 'Memcached keys prefix', 'storage_')
	.parse(process.argv);


# Configuration
app.configure () ->
	app.use express.bodyParser()
	app.use express.methodOverride()
	# app.use express.cookieParser()
	# app.use require './uid'
	app.use app.router

	app.set 'memcached', program.memcached
	app.set 'mongobase', program.mongo
	app.set 'memcachedPrefix', program.memcachedPrefix

app.configure 'development', () ->
	app.use express.errorHandler
		dumpExceptions: true
		showStack: true

app.configure 'production', () ->
	app.use express.errorHandler()

# Routes
require './api'

app.listen program.port, () ->
	console.log """
		REST server listening
		Port			: \u001b[91m#{app.address().port}\u001b[0m
		Memcached		: \u001b[91m#{app.settings.memcached}\u001b[0m
		Memcached Prefix	: \u001b[91m#{app.settings.memcachedPrefix}\u001b[0m
		MongoDB			: \u001b[91m#{app.settings.mongobase}\u001b[0m
		Mode			: \u001b[91m#{app.settings.env}\u001b[0m
	"""
