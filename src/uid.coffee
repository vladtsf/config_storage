crypto = require 'crypto'

md5 = (text) ->
	shasum = crypto.createHash 'md5'
	shasum.update text
	shasum.digest 'hex'

module.exports = (req, res, next) ->
	uid = req.cookies.cntuid

	if uid?
		req.uid = md5 uid
		next()
	else 
		res.send 403