# md5 = require './md5'

module.exports = (req, res, next) ->
	uid = req.cookies.cntuid

	if uid?
		req.uid = uid
		next()
	else 
		res.send 403