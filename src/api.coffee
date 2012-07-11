app = require './app'
memcached = require './memcached'

app.get '/version/', (req, res) ->
	res.end()

app.post '/set/', (req, res) ->
	res.end()

app.get '/data/', (req, res) ->
	res.end()