app = require './app'
memcached = require './memcached'
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Storage = require './models/storage'



app.get '/version/', (req, res) ->
	res.end()

app.post '/set/', (req, res) ->
	res.end()

app.get '/data/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
			res.json doc || {}