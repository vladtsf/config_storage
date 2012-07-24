app = require './app'
uncache = require './uncache'
Storage = require './models/storage'

app.get '/:uid/version/', (req, res) ->
	Storage.findOne uid: req.params.uid, (err, doc) ->
		if err? or not doc?
			res.send 404
		else
			res.json
				version: doc.version

app.post '/:uid/set/', (req, res) ->
	if Object.keys(req.body).length isnt 0
		Storage.findOne uid: req.params.uid, (err, doc) ->
			if err?
				res.send 503
			else
				if not doc?
					doc = new Storage 
						uid: req.params.uid
						data: req.body

					doc.save () -> uncache req.params.uid, 0, (status) -> res.send status
				else
					for key, val of req.body
						doc.data[key] = val

					Storage.update _id: doc._id,
						$inc: 
							version: 1
						$set:
							data: doc.data
					,
						() -> uncache req.params.uid, doc.version + 1, (status) -> res.send status
	else
		res.send 200

app.get '/:uid/data/', (req, res) ->
	Storage.findOne uid: req.params.uid, (err, doc) ->
		res.json if doc? then doc.data else {}