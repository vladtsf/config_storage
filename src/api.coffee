app = require './app'
memcached = require './memcached'
mongoose = require 'mongoose'

# md5 = require './md5'

Schema = mongoose.Schema
ObjectId = mongoose.Types.ObjectId

Storage = require './models/storage'

app.get '/version/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		if err? or not doc?
			res.send 404
		else
			res.json
				version: doc.version

app.post '/set/', (req, res) ->
	res.end()

app.get '/data/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
			res.json doc || {}