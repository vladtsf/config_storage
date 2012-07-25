app = require './app'
uncache = require './uncache'
Storage = require './models/storage'

app.get '/version/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		if err? or not doc?
			res.send 404
		else
			res.json
				version: doc.version

app.post '/set/', (req, res) ->
	if Object.keys(req.body).length isnt 0
		Storage.findOne uid: req.uid, (err, doc) ->
			if err?
				res.send 503
			else
				if not doc?
					doc = new Storage 
						uid: req.uid
						data: req.body

					doc.save () -> uncache req.uid, 0, (status) -> res.send status
				else
					for key, val of req.body
						doc.data[key] = val

					Storage.update _id: doc._id,
						$inc: 
							version: 1
						$set:
							data: doc.data
					,
						() -> uncache req.uid, doc.version + 1, (status) -> res.send status
	else
		res.send 200

app.get '/data/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		res.json if doc? then doc.data else {}