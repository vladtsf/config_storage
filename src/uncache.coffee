memcached = require './memcached'
app = require './app'

module.exports = (uid, version, callback) -> 
	key = "#{app.settings.memcachedPrefix}#{uid}"

	memcached.set key, 0, version, (err, result) ->
		memcached.gets key, (err, result) ->
			if err
				callback 503
			else
				memcached.cas key, 0, result.cas, version, (err, result) ->
					if err
						callback 503
					else
						callback 200