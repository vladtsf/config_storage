memcached = require './memcached'

module.exports = (uid, version, callback) -> 
	memcached.set uid, 0, version, (err, result) ->
		memcached.gets uid, (err, result) ->
			if err
				callback 503
			else
				memcached.cas uid, 0, result.cas, version, (err, result) ->
					if err
						callback 503
					else
						callback 200