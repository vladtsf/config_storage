app = require './app'
memcached = require './memcached'
mongoose = require 'mongoose'

# md5 = require './md5'

Schema = mongoose.Schema
ObjectId = mongoose.Types.ObjectId

Storage = require './models/storage'

# HUINANU
app.get '/', (req, res) ->
	res.send """
<!doctype html>
<html>
	<head>
	</head>
	<body>
		<form method="post" action="/set/">
			<input type="text" name="gamnatebe" value="huesospidaras" />
			<input type="submit" />
		</form>
	</body>
</html>
		"""

app.get '/version/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		if err? or not doc?
			res.send 404
		else
			res.json
				version: doc.version

app.post '/set/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		if err?
			res.send 503
		else
			if not doc?
				doc = new Storage 
					uid: req.uid
					data: req.body

				doc.save () -> res.send 200
			else
				for key, val of req.body
					doc.data[key] = val

				Storage.update _id: doc._id,
					$inc: 
						version: 1
					$set:
						data: doc.data
				,
					() -> res.send 200

app.get '/data/', (req, res) ->
	Storage.findOne uid: req.uid, (err, doc) ->
		res.json doc || {}

