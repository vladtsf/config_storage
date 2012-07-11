app = require './app'
Memcached = require 'memcached'

memcached = module.exports = new Memcached app.settings, 
	retries:10
	retry:10000
	remove:true